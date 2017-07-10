From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Mon, 10 Jul 2017 14:53:09 +0200
Message-ID: <14864359.mjd7iJstal@aspire.rjw.lan>
References: <20170708000303.21863-1-dbasehore@chromium.org> <20170708000303.21863-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-2-dbasehore@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 07, 2017 05:03:00 PM Derek Basehore wrote:
> Adds a new feature to tick to schedule wakeups on a CPU during freeze.

This is referred to "suspend-to-idle" nowadays.

I guess I need to update the code to be more consistent with respect to the
terminology.

Thanks,
Rafael
