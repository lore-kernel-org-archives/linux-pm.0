From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] tools/turbostat: allow user to alter DESTDIR and PREFIX
Date: Mon, 04 Jul 2016 15:08:48 +0200
Message-ID: <2932678.f1gtzO8SIO@vostro.rjw.lan>
References: <1466168373-101010-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466168373-101010-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2016 03:59:33 PM Andy Shevchenko wrote:
> When run
> 	make -C tools DESTDIR=/my/nice/dir turbostat_install
> get a message
> 	install: cannot create regular file '/usr/bin/turbostat': Permission denied
> 
> Allow user to alter DESTDIR and PREFIX variables.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thanks!
