From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace RDRAND forced-reseed with simple sanity check
Date: Mon, 3 Aug 2015 13:20:15 -0400
Message-ID: <CAJvTdKnW8oxksSZRf8X19vDG3SwnkOfQC601Bcc5odJ9FFETzA@mail.gmail.com>
References: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com>
	<20150802160332.GB28860@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150802160332.GB28860@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

> If we trust built-in-self-test...
> why do we need to do this at all? We
> should check the return value at every call, anyway...

Yes, we do trust built-in-self-test.
Yes, we do check for errors on on every call, not just here in boot.

The sanity check at boot from the kernel allows Linux to disable
the feature, preventing user-space from thrashing trying to use it.

There is also a line of reasoning that if the circuit is going to fail,
chances are that it will fail immediately.
I have no reason to believe that the circuit will fail in the field
either at run-time or at boot-time.  But that line of reasoning
suggests that O(1 usec) to check at boot is a prudent investment --
it is certainly a better investment per time than may of the other
things Linux does.

thanks,
Len Brown, Intel Open Source Technology Center
