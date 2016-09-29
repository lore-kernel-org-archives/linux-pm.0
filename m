From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Thu, 29 Sep 2016 10:17:36 -0400
Message-ID: <20160929141736.GA14309@csclub.uwaterloo.ca>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan>
 <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan>
 <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <20160927145114.GM14311@csclub.uwaterloo.ca>
 <8a5f37bb-4870-b89e-6287-fcb43b2e708f@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8a5f37bb-4870-b89e-6287-fcb43b2e708f@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 28, 2016 at 09:26:42PM -0500, Larry Finger wrote:
> By the time it gets slow, the CPU's cool, and one cannot see the temp just
> before that event happened.

Hmm, I would not expect the CPU to drop from 80 to 40 degrees in a few
seconds if the fan is not spinning.  I wouldn't even expect it if the
fan was spinning.  I would think at least 30 to 60 seconds if not more.

The only way I would think the temperature could change quickly would
be if the heatsink isn't even touching the CPU anymore so there is very
little material to hold the heat in the CPU.

> The reason I suspect a bug is that it fails with 4.8-rcX, but not with 4.7.
> Of course, it could be something subtle that slightly changes the heat load,
> which causes the CPU temp to be a little higher so that the effect is
> triggered.
> 
> I am reasonably confident that it is not a hardware problem, but we may have
> to wait until 4.8 is released and gets wider usage. If no one else reports a
> problem, then I am certainly wrong.

Well hard to reproduce bugs are always really annoying.

This old bug sounds a lot like what you are seeing:
https://bugzilla.redhat.com/show_bug.cgi?id=924570
and it links to this:
https://www.phoronix.com/scan.php?page=news_item&px=Linux-4.6-Thermal-Updates

Apparently turning off turbo boost seems to stop the problem for a lot
of people in that case.  Doesn't explain why it started happening
recently.  And of course that may have been a different problem in
the past.

-- 
Len Sorensen
