From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: declare __tracedata symbols as char[] rather than char
Date: Sun, 21 Feb 2016 14:45:20 +0100
Message-ID: <3639816.6c6FK9gNMm@vostro.rjw.lan>
References: <1453687732-1602-1-git-send-email-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453687732-1602-1-git-send-email-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-pm@vger.kernel.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, January 24, 2016 08:08:52 PM Eric Biggers wrote:
> Accessing more than one byte from a symbol declared simply 'char' is undefined
> behavior, as reported by UBSAN:
> 
> 	UBSAN: Undefined behaviour in drivers/base/power/trace.c:178:18
> 	load of address ffffffff8203fc78 with insufficient space
> 	for an object of type 'char'
> 
> Avoid this by declaring the symbols as arrays.
> 
> Signed-off-by: Eric Biggers <ebiggers3@gmail.com>

Queued up for 4.6, thanks!

Rafael
