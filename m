From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH RFC 02/12] Documentation: thermal docbook: add glossary
Date: Wed, 18 Feb 2015 11:52:21 +0000
Message-ID: <20150218115221.GD2990@e104805>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
 <1423517653-11359-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:43953 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbBRLwg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 06:52:36 -0500
Content-Disposition: inline
In-Reply-To: <1423517653-11359-3-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>, "hongbo.zhang@linaro.com" <hongbo.zhang@linaro.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "peter@piie.net" <peter@piie.net>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "aaron.lu@intel.com" <aaron.lu@intel.com>, "caesar.wang@rock-chips.com" <caesar.wang@rock-chips.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "vincenzo.frascino@st.com" <vincenzo.frascino@st.com>, "mperttunen@nvidia.com" <mperttunen@nvidia.com>, "mikko.perttunen@kapsi.fi" <mikko.perttunen@kapsi.fi>, srinivas.pandruvada@lin

Hi Eduardo,

On Mon, Feb 09, 2015 at 09:34:03PM +0000, Eduardo Valentin wrote:
> This change introduces a section in the Introduction Chapter to
> list concepts used by the Thermal Framework.
> 
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  Documentation/DocBook/thermal.tmpl | 129 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook/thermal.tmpl
> index f8fb8a2..66efed3 100644
> --- a/Documentation/DocBook/thermal.tmpl
> +++ b/Documentation/DocBook/thermal.tmpl
> @@ -84,5 +84,132 @@
>  		devices.
>  		</para>
>  
> -  </chapter>
> +		<sect1 id="glossary">
> +			<title>Glossary</title>
> +			<para>The Linux Kernel Thermal Framework  uses a
> +			specific terminology to represent the entities involved
> +			in thermal constrained environments. This section
> +			summaries the terminology as dictionary. These terms are
> +			in use within the present document and in the source
> +			code of the Linux Kernel Thermal Framework.
> +			</para>
> +			<glossary>
> +				<glossentry>
> +					<glossterm>Thermal Zone</glossterm>
> +					<glossdef>
> +						<para>Thermal zones represent
> +						what is the current status of a
> +						thermal constrained zone in the
> +						hardware. The zone usually is a
> +						device or component. The status
> +						of a thermal zone is mainly with
> +						respect to temperature.
> +						Currently, the Linux Kernel
> +						Thermal Framework represents
> +						temperature in miliCelsius. The
> +						current abstraction covers for
> +						non negative temperatures and
> +						constraints.
> +						</para>

Shall we point out that a thermal zone doesn't necessarily imply a
thermal sensor?  I find it very common to assume that if you have 10
sensors, you should have 10 thermal zones.  From my point of view, a
thermal zone is an area that has similar thermal characteristics.
Therefore, the temperature of the thermal zone doesn't necessarily
have to come from on sensor, and can be defined as a combination of
the input from multiple thermal sensors.

I don't know how to put this in proper words for the documentation,
but I think it's worth hinting it here.

Cheers,
Javi
