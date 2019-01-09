From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Date: Thu, 10 Jan 2019 00:51:39 +0800
Message-ID: <20190109165139.GH9503@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109163958.GG9503@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 12:39:58AM +0800, joeyli wrote:
> Hi Andy,
>
[...snip] 
> 
> Let's why I encrypt/decrypt data pages one by one, then I copy the
^^^^^^^ That's why

> encrypt/decrypt data from buffer page (only one buffer page reserved
> for encrypt/decrypt) to original page. I encreypt pages one by one, but
> I HMAC and verify the whole snapshot image by update mode.
> 
[...snip]
>  
> > Why are you manually supporting three different key types?  Can’t you
> > just somehow support all key types?  And shouldn’t you be verifying
> 
> I only supported two key typs in my patch set, user defined key and
> TPM trusted key. The EFI secure boot did not accept by EFI subsystem.
                   ^^^^^^^^^^^^^^^^^^^ EFI secure key
   https://lkml.org/lkml/2018/8/5/10

Sorry for I produced too many typo when feeling sleepy...

Thanks a lot!
Joey Lee
