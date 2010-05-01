From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] FS: libfs,
	implement simple_write_to_buffer
Date: Sun, 2 May 2010 00:00:36 +0200
Message-ID: <201005020000.37013.rjw__43214.0939090916$1272751291$gmane$org@sisk.pl>
References: <1272356118-10012-1-git-send-email-jslaby@suse.cz>
	<201004272358.36175.rjw@sisk.pl> <201004290016.40469.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004290016.40469.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Rafael J. Wysocki wrote:
> On Tuesday 27 April 2010, Rafael J. Wysocki wrote:
> > On Tuesday 27 April 2010, Jiri Slaby wrote:
> > > It will be used in suspend code and serves as an easy wrap around
> > > copy_from_user. Similar to simple_read_from_buffer, it takes care
> > > of transfers with proper lengths depending on available and count
> > > parameters and advances ppos appropriately.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > Cc: Nigel Cunningham <ncunningham@crca.org.au>
> > > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: linux-fsdevel@vger.kernel.org
> > 
> > Thanks for the patches, I'll review them as soon as I can.
> 
> They look good.  If there are no objections from the other people, I'll add
> them to suspend-2.6/linux-next in the next few days.

All patches in this series applied to suspend-2.6/linux-next.

I fixed up the Pavel's address in the copyright notice in kernel/power/block_io.c.

Thanks,
Rafael
