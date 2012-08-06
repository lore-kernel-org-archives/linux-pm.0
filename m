From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Mon, 6 Aug 2012 15:59:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208061556010.1649-100000@iolanthe.rowland.org>
References: <50201156.30704@pavlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <50201156.30704@pavlinux.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Vasilyev <pavel@pavlinux.ru>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Aug 2012, Pavel Vasilyev wrote:

> >> http://www.gossamer-threads.com/lists/engine?do=post_attachment;postatt_id=41157;list=linux
> >
> > Interestingly, many (all?) of the changes in that patch are wrong
> > because they don't try to match the terminating '\0'.  As a result,
> > they will match against extensions of the target string as well as the
> > target string itself.
> >
> 
> strNcmp compare N bytes - http://lxr.linux.no/#linux+v3.5/lib/string.c#L270
> memcmp compare N bytes  - http://lxr.linux.no/#linux+v3.5/lib/string.c#L651

Yes.  So if s contains "abcde" then

	memcmp(s, "abc", 3) and strncmp(s, "abc", 3) will both return 0, and
	memcmp(s, "abc", 4) and strncmp(s, "abc", 4) will both return 1.

Alan Stern
