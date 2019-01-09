From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate snapshot image
Date: Wed, 09 Jan 2019 17:47:53 +0100
Message-ID: <2049173.FbhQ43HnNr@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com> <20190109163958.GG9503@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109163958.GG9503@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 17:39:58 CET schrieb joeyli:

Hi joeyli,

> 
> I am doing encrypt-then-MAC.

Note, this is what the authenc() AEAD cipher does.

Ciao
Stephan
