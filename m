From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: i2c runtime suspend and system wide suspend
Date: Thu, 30 Dec 2010 11:49:30 +0100
Message-ID: <201012301149.30888.rjw__42524.2388774224$1293706313$gmane$org@sisk.pl>
References: <4D1C0CFE.5010008@codeaurora.org>
	<AANLkTinqqgNwgFCMVL-2T83zKnNLGLF007atJ4-EDEW5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinqqgNwgFCMVL-2T83zKnNLGLF007atJ4-EDEW5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-arm-msm@vger.kernel.org, Abhijeet Dharmapurikar <adharmap@codeaurora.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Partha Basak <p-basak2@ti.com>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, December 30, 2010, Rabin Vincent wrote:
> On Thu, Dec 30, 2010 at 10:09 AM, Abhijeet Dharmapurikar
> <adharmap@codeaurora.org> wrote:
> > The i2c-core driver mixes runtime suspend and system wide suspend, in that,
> > during a system wide suspend, it skips calling ->suspend if the device is
> > runtime suspended.
> >
> > I have an interrupt controller running over the i2c bus and that driver is
> > oblivious of the runtime pm framework, IOW, it doesn't do any runtime pm
> > calls. CONFIG_RUNTIME_PM is enabled however (for some other bus drivers).
> > The issue I am facing is that all such i2c devices are assumed runtime
> > suspended and the ->suspend for these devices is not invoked during
> > systemwide suspend.
> 
> This was discussed on linux-pm recently.  Rafael had a fix, I'm don't know
> whether it's applied yet:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029567.html
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029596.html

Yes, the fix is already in the Linus' tree:

f08f5a0 PM / Runtime: Fix pm_runtime_suspended()
 
> Also relevant:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029600.html
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029658.html

I'm not sure what happened to the last patch.  Is there a new version?
If so, is it going to be pushed through the i2c tree, or should I take it?

Rafael
