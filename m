From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily
	unavailable	pci device
Date: Wed, 18 Oct 2006 17:05:02 +0100
Message-ID: <1161187503.9363.75.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Brian King <brking@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Ar Mer, 2006-10-18 am 11:52 -0400, ysgrifennodd Alan Stern:
> Don't you want the user process to wait in TASK_INTERRUPTIBLE?  It would =

> require only a very simple change.

That just makes the problem even worse, to go with the kernel driver
"what the hell do do if.." we get a user space one thats based around
incompatibility with the existing behaviour.

There are much saner ways to sort that out without breaking the API

If its going to be a bounded short wait -> pause
If its might be a long wait -> cached
If its gone for good then error

If the user specified O_NDELAY then -EWOULDBLOCK not wait

That way you don't break anything and you get sensible Unix semantics.
The wait queue Matthew added also means select() can be fitted up to do
the right thing for the O_NDELAY case.

Alan
