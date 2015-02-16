From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH RFC 02/12] Documentation: thermal docbook: add glossary
Date: Mon, 16 Feb 2015 15:01:25 +0200
Message-ID: <54E1EA25.3000308@kapsi.fi>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com> <1423517653-11359-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:33693 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755397AbbBPNBl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Feb 2015 08:01:41 -0500
In-Reply-To: <1423517653-11359-3-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On 02/09/2015 11:34 PM, Eduardo Valentin wrote:
> This change introduces a section in the Introduction Chapter to
> list concepts used by the Thermal Framework.
>
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   Documentation/DocBook/thermal.tmpl | 129 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 128 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook/thermal.tmpl
> index f8fb8a2..66efed3 100644
> --- a/Documentation/DocBook/thermal.tmpl
> +++ b/Documentation/DocBook/thermal.tmpl
> @@ -84,5 +84,132 @@
>   		devices.
>   		</para>
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

milli-Celsius or millicelsius. Same change later too.

> +						current abstraction covers for
> +						non negative temperatures and
> +						constraints.
> +						</para>
> +					</glossdef>
> +				</glossentry>
> +				<glossentry>
> +					<glossterm>Thermal Sensors</glossterm>
> +					<glossdef>
> +						<para>Thermal sensors provide
> +						temperature sensing capabilities
> +						on thermal zones. Typical
> +						devices are I2C ADC converters
> +						and bandgaps. These are nodes
> +						providing temperature data to
> +						thermal zones. Thermal sensor
> +						devices may control one or more
> +						internal sensors.
> +						</para>
> +					</glossdef>
> +				</glossentry>
> +				<glossentry>
> +					<glossterm>Trips Points</glossterm>
> +					<glossdef>
> +						<para>The trip node describes a
> +						point in the temperature domain
> +						in which the system takes an
> +						action. This item describes just
> +						the point, not the action. Trip
> +						points are represented as
> +						temperature in miliCelsius. The

here

> +						current abstraction covers for
> +						non negative temperatures.

One thing I'd also like to see documented is the roles of the different 
trip types (PASSIVE, ACTIVE, HOT, CRITICAL) and when each should be used.

> +						</para>
> +					</glossdef>
> +				</glossentry>
> +				<glossentry>
> +					<glossterm>Thermal Governor</glossterm>
> +					<glossdef>
> +						<para>Thermal Governors
> +						represent a policy to manage the
> +						thermal zone device temperature.
> +						The governor targets to keep
> +						temperature in an acceptable
> +						range which correlates to the
> +						power budget, while maximizing
> +						the performance. Governors can
> +						be implemented in Kernel Space
> +						or in User Space.
> +						</para>
> +					</glossdef>
> +				</glossentry>
> +				<glossentry>
> +					<glossterm>Thermal Cooling Device</glossterm>
> +					<glossdef>
> +						<para>Cooling devices provide
> +						control on power dissipation.
> +						There are essentially two ways
> +						to provide control on power
> +						dissipation. First is by means
> +						of regulating device
> +						performance, which is known as
> +						passive cooling. A typical
> +						passive cooling is a CPU that
> +						has dynamic voltage and
> +						frequency scaling (DVFS), and
> +						uses lower frequencies as
> +						cooling states. Second is by
> +						means of activating devices in
> +						order to remove the dissipated
> +						heat, which is known as active
> +						cooling, e.g. regulating fan
> +						speeds. In both cases, cooling
> +						devices shall have a way to
> +						determine the state of cooling
> +						in which the device is.
> +				</para>
> +					</glossdef>
> +				</glossentry>
> +				<glossentry>
> +					<glossterm>Cooling State</glossterm>
> +					<glossdef>
> +						<para>Any cooling device has a
> +						range of cooling states (i.e.
> +						different levels of heat
> +						dissipation). For example a
> +						fan's cooling states correspond
> +						to the different fan speeds
> +						possible. Cooling states are
> +						referred to by single unsigned
> +						integers, where larger numbers
> +						mean greater heat dissipation.
> +						The precise set of cooling
> +						states associated with a device
> +						(as referred to be the
> +						cooling-min-state and
> +						cooling-max-state properties)
> +						should be defined in a
> +						particular device's binding.
> +						</para>
> +					</glossdef>
> +				</glossentry>
> +			</glossary>
> +		</sect1>
> +	</chapter>
>   </book>
>

Cheers,
Mikko.

