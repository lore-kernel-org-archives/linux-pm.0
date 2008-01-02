From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
 suspended (rev. 2)
Date: Wed, 2 Jan 2008 19:34:15 +0100
Message-ID: <20080102193415.1d7af667__22571.040216326$1199299299$gmane$org@i1501.lan.towertech.it>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
	<200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu>
	<3ae72650801020655h6ec31ce8n5cd9014c00c9f6ad@mail.gmail.com>
	<20080102160137.GA21046@elte.hu>
	<20080102175400.3C2E0EF588@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080102190537.2fc735fe@i1501.lan.towertech.it>
	<20080102181254.3469E28CE0F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080102181254.3469E28CE0F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: gregkh@suse.de, akpm@linux-foundation.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, mingo@elte.hu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 02 Jan 2008 10:12:54 -0800
David Brownell <david-b@pacbell.net> wrote:

> > > It'd need to have some NTP sync solution for RTC_LIB devices, but
> > > ISTR the gentime stuff still assumes an update_persistent_clock()
> > > that doesn't sleep ... and hence can't be used with I2C based RTCs.
> >
> > I still believe NTP sync stuff should be done outside of the kernel.
> > given the mean accuracy of RTC chips and other sync factors, imho
> > you haven't so much to gain with an in-kernel sync code.
> 
> Then the kernel/time/ntp.c stuff should be removed on all systems?

 I'd say yes, but I think that would be dangerous to my own life :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
