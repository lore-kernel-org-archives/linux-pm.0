From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Mon, 25 Jun 2007 15:04:08 +0200
Message-ID: <20070625130408.GA20203__46548.8632479266$1182776753$gmane$org@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org>
	<200706240203.12970.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706240203.12970.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Right now the states we have are On, Standby, and Suspend, and the CPU
> > runs only in the On state.  But on some platforms there could be
> > multiple states in which the CPU is able to run, albeit with degraded 
> > performance.
> 
> I wouldn't call those system sleep states.  For example, ACPI defines system
> sleep states as the states in which no instructions are executed by any CPUs
> and I think that's reasonable.

Well, in some cases, we have 200MHz CPU running at 30kHz. ...that's so
slow that it is pretty similar to ACPI sleep state.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
