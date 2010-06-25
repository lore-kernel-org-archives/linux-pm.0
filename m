From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/9=5D_PM_/_Hibernate=3A_swap?=
 =?iso-8859-1?q?=2C_=09switch_to_hibernate=5Fio=5Fhandle?=
Date: Fri, 25 Jun 2010 16:00:37 +0200
Message-ID: <201006251600.37455.rjw__37586.2815803432$1277474581$gmane$org@sisk.pl>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<4C1F8366.70306@gmail.com> <4C1FE09B.9040703@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C1FE09B.9040703@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 21, 2010, Nigel Cunningham wrote:
> Hi Jiri.
> 
> On 22/06/10 01:21, Jiri Slaby wrote:
> > On 06/11/2010 11:46 AM, Nigel Cunningham wrote:
> >> On 02/06/10 18:52, Jiri Slaby wrote:
> >>> I addressed the comments I got on the previous RFC. I left the handles
> >>> in place, the functions in hibernate_io_ops now works on them. Further
> >>> I got rid of the memory barriers and minimized global variables as much
> >>> as possible. Comments welcome.
> >>
> >> I would like to hear the arguments for using these handles. I understand
> >> there may have been some previous discussion, but am unable to find it.
> >>
> >> It seems far more sensible to me to not pass around a handle that
> >> virtually nothing actually uses, and instead store and utilise the state
> >> in the place where it is actually useful. If we had more than one struct
> >> hibernate_io_handle in use at a time, I could understand going this way.
> >> As it stands, however...
> >
> > Hi, it I added that based on this: http://lkml.org/lkml/2010/3/24/458
> 
> Okay; thanks.
> 
> Looking at Pavel's comment is confusing. The variable you were adding 
> isn't "global static" (that's a contradiction in terms anyway). Its 
> scope is the file level.
> 
> Since the data is only used in this file, your change makes perfect 
> sense to me.
> 
> Rafael, Pavel: care to discuss this further?

Well.  Generally speaking, I like things as they are, except for patches [3/9]
and [4/9].

So, I'd like to take [1-2/9] and [5-9/9].  Jiri, do [6-7/9] need to be changed
substantially in case [3-4/9] are dropped?

Rafael
