From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 20:04:46 -0700
Message-ID: <adak6334my9.fsf@cisco.com>
References: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030229AbWJNDEu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org> (Alan Stern's message of "Fri, 13 Oct 2006 22:33:04 -0400 (EDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>, Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

    Alan> That seems like a reasonable thing to do.  (BTW, can anyone
    Alan> explain quickly what "BIST" means?)

"Built-In Self Test" -- make the device go away and run some internal
tests for a while and then report back.
