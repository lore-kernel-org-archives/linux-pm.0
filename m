From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Re: [RFC][PATCH -mm] PM: Introduce set_target method
	in	pm_ops
Date: Mon, 25 Jun 2007 17:57:47 +0400
Message-ID: <467FC9DB.3080704__38400.4257772633$1182779930$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org>	<200706240203.12970.rjw@sisk.pl>
	<20070625130408.GA20203@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070625130408.GA20203@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>>> Right now the states we have are On, Standby, and Suspend, and the CPU
>>> runs only in the On state.  But on some platforms there could be
>>> multiple states in which the CPU is able to run, albeit with degraded 
>>> performance.
>> I wouldn't call those system sleep states.  For example, ACPI defines system
>> sleep states as the states in which no instructions are executed by any CPUs
>> and I think that's reasonable.
>
> Well, in some cases, we have 200MHz CPU running at 30kHz. ...that's so
> slow that it is pretty similar to ACPI sleep state.
> 									
Pavel,

let's do not mix the things. Rafael gave exact meaning of a sleep state --
"no instructions are executed by any CPUs", that, I assume, can be
interpreted
as "processor does not do any effective job". It does not mean if any clock
frequency supplied or not. In some cases the frequency supplied to speed up
the wakeup process, but, the processor can't operate on this frequency,
so this is a sleep state. But, if the processor can do some job,
even if a frequency very very slow, then this is an active mode.


Regards,
Dmitry
