From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Sun, 23 Jun 2013 23:59:03 +0200
Message-ID: <7303551.DgZO2t6GUO@vostro.rjw.lan>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com> <3043483.hQyzHovghE@vostro.rjw.lan> <1371987257.3137.44.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371987257.3137.44.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Shuah Khan <shuah.kh@samsung.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, June 23, 2013 04:34:17 AM Joe Perches wrote:
> On Sun, 2013-06-23 at 13:36 +0200, Rafael J. Wysocki wrote:
> > Please keep the existing format as is literally and append any
> > new information to the end of the line.
> 
> Hi Shuah.
> 
> Perhaps the better long-term approach would be to add
> a new tracepoint too.

In fact, I would even prefer it if new tracepoints were added so that we
could deprecate the dmesg messages at one point in the future.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
