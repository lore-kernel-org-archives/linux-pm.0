From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Thu, 22 Apr 2010 05:43:48 +0200
Message-ID: <201004220543.48943.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003312229.18142.rjw@sisk.pl> <4BCF6C7F.7020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BCF6C7F.7020807@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 April 2010, Jiri Slaby wrote:
> On 03/31/2010 10:29 PM, Rafael J. Wysocki wrote:
> > On Wednesday 31 March 2010, Jiri Slaby wrote:
> >> On 03/30/2010 10:50 PM, Rafael J. Wysocki wrote:
> >>> So, I definitely would like to see numbers.
> >>
> >> With the patch attached, I get similar results for
> >> uncompressed image -> user.c -> s2disk (compress+threads)
> >> compressed image -> user.c -> s2disk (none of compress+threads)
> >>
> >> BUT note that there are differences in pages _copied_ in the "user.c ->
> >> s2disk" phase. Compression was about 40 %. So in the former case 100000
> >> pages went through and in the latter one only ~ 38000. So presumably
> >> there will be savings if the pages are compressed in the kernel in the
> >> save-image phase instead of in userspace.
> >>
> >> I'll test (after I hack that up) also the case of image compression when
> >> saving the image and let you know.
> >>
> >> It was tested on a machine with openSUSE factory with init 5 with KDE 4.
> >> The memory consumption was ~ 400M (100000 pages) after boot every time.
> >> Hibernation lasted 12-13s in both cases.
> > 
> > So that's pretty much the same and I don't think feeding compressed images to
> > s2disk is not worth the effort.  Let's assume s2disk will always receive a raw
> > image (that will make it backwards compatible too).
> 
> Hi.
> 
> Yes, I did it solely for comparison purposes.
> 
> Now, with the patch attached (depending on either COMPRESS_IMAGE or
> COMPRESS_IMAGE1 defined) I tried to compare compression while doing
> atomic copy with compression done when image storage takes place. The
> latter outperformed the former a bit. I did 8 measurements with the
> setup same as above. The average for them is 9684.32 and 10855.07 stored
> raw (uncompressed) pages per second. That is 4.5M/s more.
> 
> There is a sheet with the numbers at:
> http://spreadsheets.google.com/ccc?key=0AvVn7xYA1DnodHFFYzg3Y2tpMUl5NFlURXRtR0xQdmc&hl=en

Thanks for doing that work!

So clearly from performance POV it is better to compress while saving.

Rafael
