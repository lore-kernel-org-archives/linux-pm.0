From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] hwmon: exynos4: Move thermal sensor
 driver to driver/mfd directory
Date: Sat, 3 Mar 2012 16:44:10 +0000
Message-ID: <20120303164410.GB1495@sirena.org.uk>
References: <1330772767-16120-1-git-send-email-amit.kachhap@linaro.org>
	<1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1330772767-16120-3-git-send-email-amit.kachhap@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 03, 2012 at 04:36:05PM +0530, Amit Daniel Kachhap wrote:
> This movement is needed because the hwmon entries and corresponding
> sysfs interface is a duplicate of utilities already provided by
> driver/thermal/thermal_sys.c. The goal is to place it in mfd folder
> and add necessary calls to get the temperature information.

> --- a/Documentation/hwmon/exynos4_tmu
> +++ /dev/null

Moving this seems to be a failure, the device is exposing a hwmon
interface even if you've moved the code to mfd (though it doesn't
actually look like a multi-function device at all as far as I can see -
usually a MFD would have a bunch of unrelated functionality while this
has one function used by two subsystems).

If anything it looks like the ADC driver ought to be moved into IIO with
either generic or Exynos specific function drivers layered on top of it
in hwmon and thermal making use of the values that are read.
