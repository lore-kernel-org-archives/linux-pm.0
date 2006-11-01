From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 18:25:47 +0100
Message-ID: <200611011825.47710.ak@suse.de>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <20061101055435.GB4933@mellanox.co.il> <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ernst Herzberg <earny@net4u.de>, Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org


> I suspect reverting it is the right thing to do - the patch only 
> introduces bugs, an doesn't actually _fix_ anything, it just "cleans 
> things up".

Ok please revert the i386 patch for now then if it fixes the ThinkPads. 
The x86-64 version should be probably fixed too, but doesn't cleanly. I will 
send you later a patch to fix this there properly.

-Andi
