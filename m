From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrinking memory for suspend?
Date: Fri, 4 May 2007 14:11:43 +0200
Message-ID: <200705041411.44247.rjw@sisk.pl>
References: <200705031245.05454.rjw@sisk.pl> <200705041102.57944.rjw@sisk.pl>
	<17979.4019.603174.454513@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <17979.4019.603174.454513@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 12:49, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > IMO, the freezing of user space and the freezing of kernel threads are two
> > different issues.  While the freezing of user space is pretty straightforward,
> > the freezing of kernel threads is difficult.
> 
> In general I agree, but now that we have FUSE, plus the framework for
> doing device drivers in userspace (I have forgotten its name), it gets
> even more complicated because some userspace processes are now doing
> the sorts of things that kernel threads do.
> 
> This is relevant for me because I use encfs regularly, and encfs is
> based on FUSE.  What happens if there is an encfs filesystem mounted,
> and we freeze all userspace processes and then do a sys_sync()?  Does
> the system wait forever for the encfs filesystem to write out its
> dirty data?

Well, that's a good question and I'm afraid the answer is 'yes'.

Still, I think we can try to solve this particular problem instead of trying to
get rid of the freezing entirely, because it that case we'll have many other
problems to fix.

Greetings,
Rafael
