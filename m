From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] swsusp: use less memory during
	resume
Date: Tue, 18 Apr 2006 15:07:55 +0200
Message-ID: <20060418130755.GB26668@elf.ucw.cz>
References: <200604181319.47400.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71996463485506856=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604181319.47400.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============71996463485506856==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Currently during resume swsusp puts the image data in the page frames that
> don't conflict with the original locations of the data (ie. the locations the
> data will be put in when the saved system state is restored from the image).
> These page frames are considered as "safe" and the other page frames are
> treadet as "unsafe".
> 
> Of course we cannot force the memory allocator to allocate "safe" pages only,
> so if an "unsafe" page is allocated, swsusp treats it as an "eaten page" and
> attempts to allocate another page in the hope that it'll be "safe" etc.
> swsusp tries to allocate as many "safe" pages as necessary to store the
> image data, so it "eats" a considerable number of "unsafe" pages in the
> process.  Next, it reads the image and puts the data into the allocated "safe"
> pages.  Finally, the data are copied to their "original" locations.
> 
> This approach, although it works nicely, is quite inefficient from the memory
> utilization point of view and it also turns out to be unnecessary.  Namely,
> for each "unsafe" page frame returned by the memory allocator there's exactly
> one page in the image that finally should be placed in this page frame.
> Therefore we can put the right data into this page frame as soon as they're
> read from the image and we won't have to copy these data later on.  This way
> we'll only need to allocate as many pages as necessary to store the image
> data and we won't have to "eat" the "unsafe" pages.

Looks good to me. Clever hack, I'd say.
									Pavel
-- 
Thanks for all the (sleeping) penguins.

--===============71996463485506856==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71996463485506856==--
