From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/4] poweroff-source DT property renaming
Date: Wed, 5 Nov 2014 10:39:12 +0100
Message-ID: <20141105093912.GM31358@localhost>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:44411 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbaKEJmX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 04:42:23 -0500
Content-Disposition: inline
In-Reply-To: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>
Cc: heiko@sntech.de, grant.likely@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Wed, Oct 29, 2014 at 07:35:31AM +0000, Romain Perier wrote:
> The goal of this serie is to rename the property "poweroff-source" to 
> "system-power-controller" and to fix things incrementally.

Please mention (here and in the commit message) that this is a rename
back to the old and fairly established property name, but without the
vendor prefix.

Essentially, it is a revert of a commit that is only in the regulator
tree.

> Changes and explanations since v1:
> 
>   - The first patch defines "of_is_system_power_controller" which is compatible
>     with both "vendor,system-power-controller" and "system-power-controller"
>     properties. Also, It keeps the old helper function of_system_has_poweroff_source
>     for source compatibility until everything is renamed (in this way, bisections
>     are not broken and change is made "atomically" between each commit)
> 
>     Note: the property "poweroff-source" itself is not used in dts files yet.
>     Before this patch tps65910 was broken due to missing backward compatibility
>     with "vendor,system-power-controller". As the old helper uses the new one,
>     it works again.

What patch broke tps65910? Please refer to it using commit id and
summary (in parenthesis).

Is that commit currently only in the regulator tree? If so, that could
be an argument for not doing this change incrementally (but that's not
my decision to make).

> 
>   - act8865 and tps65910 are ported to the new helper function
> 
>   - The last commit removes the olf helper which was only used for
>   source compatibility

I think you should squash the last three patches (i.e. update the
drivers and remove the helper in one patch).

> Romain Perier (4):
>   of: Rename "poweroff-source" property to "system-power-controller"
>   regulator: act8865: Convert poweroff-source DT property to
>     system-power-controller
>   mfd: tps65910: Convert poweroff-source DT property to
>     system-power-controller
>   of: Remove of_system_has_poweroff_source helper function

Please do not mix patch revisions in your Subject lines when submitting
an updated series. Update the revision number for the series and all
patches in it even if a single patch happens to be unchanged (or new as
patch 4/4).

Johan
