From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Sun, 06 Jan 2019 09:25:57 +0100
Message-ID: <7661280.VaQ99ZmoaG@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <20190103143227.9138-2-jlee@suse.com> <4539995.kc8yiMsNgQ@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4539995.kc8yiMsNgQ@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Sonntag, 6. Januar 2019, 09:01:27 CET schrieb Stephan Mueller:

Hi,

> > +	memcpy(skey.key, ukp->data, ukp->datalen);
> 
> Where would skey.key be destroyed again?

Now I see it - it is in patch 4. Please disregard my comment.

Ciao
Stephan
