From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Tue, 08 Jan 2019 08:09:43 +0100
Message-ID: <1565399.7ulKdI1fm5@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de> <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:

Hi Herbert,

> Are we going to have multiple implementations for the same KDF?
> If not then the crypto API is not a good fit.  To consolidate
> multiple implementations of the same KDF, simply provide helpers
> for them.

It is unlikely to have multiple implementations of a KDF. However, KDFs relate 
to hashes like block chaining modes to raw block ciphers. Thus a KDF can be 
applied with different hashes.

My idea was to add template support to RNGs (because KDFs are effectively a 
type of RNG since they produce an arbitrary output from a fixed input). The 
KDFs would be a template wrapping hashes. For example, the CTR-KDF from 
SP800-108 could be instantiated like kdf-ctr(sha256).

Ciao
Stephan
