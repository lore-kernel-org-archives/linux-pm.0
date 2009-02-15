From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 00:10:15 +0100
Message-ID: <200902160010.16955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The recent descussion about the Android PM patches sent by Arve shows that
there is a need to introduce a mechanism allowing us to:
(1) automatically put the system as a whole into a sleep state (eg. suspend to
    RAM) when it is found to be "idle", where the meaning of "idle" has to be
    defined too,
(2) put given subset of devices into low power states whenever they are not
    used, without putting the entire system into a sleep state.
To allow these two things to happen, the Andriod patches introduced the
wakelocks with the associated infrastructure and the "early suspend" mechanism.
However, quite a number of reviewers did not like these patches, for various
reasons, so they cannot be regarded as generally acceptable.  For this reason,
I think, we should discuss the problem in detail from the beginning and try to
find a solution that everyone interested will be comfortable with.

For this purpose, IMO, we should at least reach an agreement on what the
kernel's and the userland's roles in (1) and (2) are going to be.  There also
are quite a few questions that need to be answered.  For instance, what
conditions are going to be used to decide whether or not the system is idle
enough so that we can put it into a sleep state?  How are we going to check
these conditions?  What is going to happen if one (or more) of them changes
while a system-wide power transition (eg. suspend) is in progress?  Are we
going to allow the user space to take part in this and if so, to what extent?
What mechanisms are going be used to put devices into low power states at run
time (ie. before starting any system-wide power transition) and how are they
going to be related to the suspend-resume infrastructure used during
system-wide power transitions?  The answers to these (and other related)
questions will likely affect all of the future Linux PM developlent, so IMO
this is a very important matter.

Opinions and comments welcome.

Thanks,
Rafael
