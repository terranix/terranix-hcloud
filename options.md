# hetzner cloud options

<ul>
<li>
  <b><u>hcloud.enable</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: true<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: Whether to enable hcloud provider
See https://www.terraform.io/docs/providers/hcloud/index.html for documentation.
.<br>
</li>
<li>
  <b><u>hcloud.export.nix</u></b><br>
  <b>type</b>: null or string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/export.nix">module/export.nix</a><br>
  <b>description</b>: Export hcloud information as nix file.
Useful when if you want to import
run a NixOS script after the terraform.
<br>
</li>
<li>
  <b><u>hcloud.nixserver</u></b><br>
  <b>type</b>: attribute set of submodules<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: create a nixos server, via nixos-infect.
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.backups</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: enable backups or not
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.channel</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;nixos-21.05&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: nixos channel to install
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.configurationFile</u></b><br>
  <b>type</b>: null or path<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: The configuration.nix,
only used by the initial
provisioning by nixos-infect.
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.enable</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: true<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: Whether to enable nixserver.<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.extraConfig</u></b><br>
  <b>type</b>: attribute set<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: parameter of the hcloud_server which are not covered yet.
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.location</u></b><br>
  <b>type</b>: null or string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: location where the machine should run.
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.name</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;nixserver-‹name›&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: name of the server
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.provisioners</u></b><br>
  <b>type</b>: list of attribute sets<br>
  <b>default</b>: []<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: provision steps. see `hcloud.server.provisioners`.
<br>
</li>
<li>
  <b><u>hcloud.nixserver.&lt;name&gt;.serverType</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;cx11&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/nixserver.nix">module/nixserver.nix</a><br>
  <b>description</b>: Hardware equipment.This options influences costs!
<br>
</li>
<li>
  <b><u>hcloud.provider.endpoint</u></b><br>
  <b>type</b>: null or string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: Hetzner Cloud API endpoint,
can be used to override the default API Endpoint https://api.hetzner.cloud/v1
<br>
</li>
<li>
  <b><u>hcloud.provider.token</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;${ var.hcloud_api_token }&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: You need an API token to use the API.
Sign in into the Hetzner Cloud Console choose a project,
go to Access → Tokens, and create a new token. Make sure
to copy the token because it won’t be shown to you again.
A token is bound to a project, to interact with the API of another
project you have to create a new token inside the project

If you use a variable you can set it via the environment variable
TF_VAR_hcloud_api_token.
<br>
</li>
<li>
  <b><u>hcloud.server</u></b><br>
  <b>type</b>: attribute set of submodules<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: servers deployed to the hcloud.
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.backups</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: enable backups or not
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.enable</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: true<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: Whether to enable really deploy server
.<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.extraConfig</u></b><br>
  <b>type</b>: attribute set<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: parameter of the hcloud_server which are not covered yet.
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.image</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;ubuntu-18.04&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: image to spawn on the server
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.location</u></b><br>
  <b>type</b>: null or string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: location where the machine should run.
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.name</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;‹name›&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: name of the server
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.provisioners</u></b><br>
  <b>type</b>: list of attribute sets<br>
  <b>default</b>: []<br>
  <b>example</b>: [{&#34;file&#34;:{&#34;destination&#34;:&#34;/root/.zshrc&#34;,&#34;source&#34;:&#34;~/.zshrc&#34;}},{&#34;remote-exec&#34;:{&#34;inline&#34;:[&#34;shutdown -r +1&#34;]}}]<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: provision steps.

`file` and `remote-exec` steps
automatically get the connection
part setup, if you configure
the `provisioner.privateKeyFile`
parameter.
<br>
</li>
<li>
  <b><u>hcloud.server.&lt;name&gt;.serverType</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;cx11&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/terranix/terranix-module-hcloud/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: Hardware equipment. This options influences costs!
<br>
</li>
</ul>
