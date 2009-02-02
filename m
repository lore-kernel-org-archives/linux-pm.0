From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 10:05:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902021000420.2550-100000@iolanthe.rowland.org>
References: <200902021142.15092.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902021142.15092.u.luckas@road.de>
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

On Mon, 2 Feb 2009, Uli Luckas wrote:

> Hi Alan,
> we have had a (userspace) wake-lock implementation on our handyPC devices for 
> a couple of years now. So maybe I can shed some light.
> 
> The above quote underlines pretty well, where Arve's and your ideas of 
> eraly-suspend and wake-locks diverge. And why you are missunderstanding each 
> other.
> Arve is always talking about "blanking the screen" because that's what the 
> users sees. From the user's perspective the device is "suspended" as soon as 
> his user interfaces vanishes. That's probably also why his notions 
> of "suspend" and "wake" are not alway following a strict definition. 

And that's partly why I have been complaining about the things he 
writes.  To a kernel programmer, "suspend" has a very specific meaning, 
quite different from what it might mean to a user.  When Arve posts on 
a kernel-oriented mailing list, he should use such words in a way his 
readers will understand.

> If the device stays blanked while the user has his 10 min phone conversation, 
> then he won't even notice wether the device suspends or not after the call. 
> This is the idea. The user does not care for anything they can't see.
> 
> Arve is not talking about a laptop that needs to sleep befor it's ventilation 
> slot are covered. He is talking about a phone that could well do with only 
> blanking it's screen. Except it want's to save battery when ever possible.

The problem is that he's talking about making changes to a kernel that 
will be installed in all sorts of machines, from phones all the way up 
to supercomputers.  When you do this, you have to broaden your point of 
view -- your code has to run correctly in all of these settings.

Alan Stern
