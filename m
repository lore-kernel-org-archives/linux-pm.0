From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sun, 8 Mar 2009 08:34:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0903080833020.32373-100000@netrider.rowland.org>
References: <20090308083243.GD1371@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090308083243.GD1371@ucw.cz>
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
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sun, 8 Mar 2009, Pavel Machek wrote:

> > I don't know the details of sleepy linux so I'd appreciate if someone can 
> > eluminate if the following scenarios could be handled efficiently with sleepy 
> > linux:
> > 1) You wake up through RTC, read the battery, update the color of your 
> >    fancy 'battery good' LED and go back to sleep imediately. The real work
> >    takes milliseconds.
> 
> This should work.
> 
> > 2) You send a request to the internet and go idle by selecting for an answer.
> >    You probably don't want to go to sleep as you know, the answer will be
> >    there shortly.
> 
> Way to get this to work would be to keep the system woke up 300msec or
> so after each network packet -- assuming that if one came another is
> probably coming soon.

That sounds like a perfect use for a suspend_blocker with a timeout!

Alan Stern
