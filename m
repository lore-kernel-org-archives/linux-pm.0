From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Tue, 3 Feb 2009 20:15:22 +0000 (UTC)
Message-ID: <19700101001327.GA1239__1826.06496750868$1233692202$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0902021000420.2550-100000@iolanthe.rowland.org>
	<200902021715.43233.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu, 1 Jan 1970 01:13:28 +0100
Content-Disposition: inline
In-Reply-To: <200902021715.43233.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org


> > The problem is that he's talking about making changes to a kernel that
> > will be installed in all sorts of machines, from phones all the way up
> > to supercomputers.  When you do this, you have to broaden your point of
> > view -- your code has to run correctly in all of these settings.
> >
> Well, it should not interfere with any of these settings. And I think it is 
> understood by now that we has to take back the semantic change of "echo mem 
> > /sys/power/state"
> 
> On the other hand, I think it is quite reasonable to have aditional suspend 
> mechanisms on a phone then you have on a super computer. Obviously you don't 
> want the supercomputer to suspend everytime nobody is watching :-)

Actually you'd like your supercomputer to turn on wake-on-lan then
sleep when noone is watching (and there are no pending jobs). 'green
datacenter' is popular buzzword ;-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
