From: Rabin Vincent <rabin@rab.in>
Subject: Re: i2c runtime suspend and system wide suspend
Date: Thu, 30 Dec 2010 12:02:53 +0530
Message-ID: <AANLkTinqqgNwgFCMVL-2T83zKnNLGLF007atJ4-EDEW5__35644.4272133105$1293690837$gmane$org@mail.gmail.com>
References: <4D1C0CFE.5010008@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D1C0CFE.5010008@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Cc: Partha Basak <p-basak2@ti.com>, linux-arm-msm@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 30, 2010 at 10:09 AM, Abhijeet Dharmapurikar
<adharmap@codeaurora.org> wrote:
> The i2c-core driver mixes runtime suspend and system wide suspend, in that,
> during a system wide suspend, it skips calling ->suspend if the device is
> runtime suspended.
>
> I have an interrupt controller running over the i2c bus and that driver is
> oblivious of the runtime pm framework, IOW, it doesn't do any runtime pm
> calls. CONFIG_RUNTIME_PM is enabled however (for some other bus drivers).
> The issue I am facing is that all such i2c devices are assumed runtime
> suspended and the ->suspend for these devices is not invoked during
> systemwide suspend.

This was discussed on linux-pm recently.  Rafael had a fix, I'm don't know
whether it's applied yet:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029567.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029596.html

Also relevant:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029600.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029658.html
