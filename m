From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC 5/5] pm: remove kernel thread freezing
Date: Tue, 3 Oct 2017 22:17:00 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710032215140.17517@jbgna.fhfr.qr>
References: <20171003185313.1017-1-mcgrof@kernel.org>  <20171003185313.1017-6-mcgrof@kernel.org> <1507061605.2567.13.camel@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507061605.2567.13.camel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "tytso@mit.edu" <tytso@mit.edu>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "ONeukum@suse.com" <ONeukum@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nborisov@suse.com" <nborisov@suse.com>, "oleg.b.antonyan@gmail.com" <oleg.b.antonyan@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Oct 2017, Bart Van Assche wrote:

> What about the many drivers outside filesystems that use the 
> set_freezable() / try_to_freeze() / wait_event_freezable() API?

Many/most of them are just completely bogus and pointless. I've killed a 
lot of those in the past, but the copy/paste programming is just too 
strong enemy to fight against.

-- 
Jiri Kosina
SUSE Labs
