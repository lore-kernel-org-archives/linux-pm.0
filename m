From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Thu, 24 Feb 2011 12:00:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102241154540.2084-100000@iolanthe.rowland.org>
References: <20110224161732.GA6512@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110224161732.GA6512@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <markgross@thegnar.org>
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 Feb 2011, mark gross wrote:

> > How careful do you want to be here?  For example, which of the
> > following inputs do you want to accept?
> > 
> > 	0x1234
> > 	abcd1234
> > 	abcd123456
> > 	abcd123456\n
> > 	abcd1234567
> > 	1234567890
> > 	1234567890\n
> > 	12345678901
> 
> > 	0x12345678
> > 	0x12345678\n
> just these 2 are what I had planned to allow after this email thread.
> 
> > 	0x123456789
> > 
> > Maybe it's okay to be a little relaxed about this, and trust the caller 
> > to pass in data that makes sense.
> yeah but is it worth the effort?

Checking for exactly those two forms really is a lot of effort.  You
have to make sure the first two characters are "0x" or "0X", you have
to check that each of the next eight characters is a valid hex digit,
and you have to verify that the 11th character, if present, is a
newline.

If you can get results that are good enough just by calling
strict_strtoul() without all these checks, it's probably worthwhile.

Alan Stern
