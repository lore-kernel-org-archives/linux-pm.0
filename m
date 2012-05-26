From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 25 May 2012 22:01:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
References: <20120419163055.GB11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419163055.GB11484@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>, Andrey Rahmatullin <wrar@wrar.name>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Steve and Andrey:

It turns out that the proposed solution for your problem causes a
regression on other ASUS computers (see Bugzilla 43278).  Rafael's got a
proposal for a replacement.

Can you try out the patch attached to comment #61 of Bugzilla 42728?  It
may even allow USB wakeup to work for you (but I wouldn't count on it!).
Thanks.

Alan Stern
