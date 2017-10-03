From: Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [RFC 0/5] fs: replace kthread freezing with filesystem
 freeze/thaw
Date: Tue, 3 Oct 2017 20:59:26 +0000
Message-ID: <1507064365.2567.36.camel@wdc.com>
References: <20171003185313.1017-1-mcgrof@kernel.org>
         <20171003193300.GD5362@ming.t460p> <20171003200511.GD2294@wotan.suse.de>
         <20171003204755.GB8848@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47219 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdJCU7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2017 16:59:31 -0400
In-Reply-To: <20171003204755.GB8848@bombadil.infradead.org>
Content-Language: en-US
Content-ID: <4B44B2AFF4B5EA498A900C8C99DEA270@namprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "willy@infradead.org" <willy@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "ONeukum@suse.com" <ONeukum@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nborisov@suse.com" <nborisov@suse.com>, "oleg.b.antonyan@gmail.com" <oleg.b.antonyan@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jgross@suse.com" <jgross@suse.com>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>, todd.e.brandt@linux.intel.co

T24gVHVlLCAyMDE3LTEwLTAzIGF0IDEzOjQ3IC0wNzAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gVGhlIFNDU0kgbGF5ZXIgY2FuIHNlbmQgU0NTSSBjb21tYW5kczsgdGhleSBhcmVuJ3QgSS9P
cyBpbiB0aGUgc2Vuc2UgdGhhdA0KPiB0aGV5IGRvIHJlYWRzIGFuZCB3cml0ZXMgdG8gbWVkaWEs
IGJ1dCB0aGV5IGFyZSBibG9jayByZXF1ZXN0cy4gIE1heWJlIHRob3NlDQo+IHNob3VsZCBiZSBh
bGxvd2VkIGV2ZW4gdG8gZnJvemVuIGRldmljZXM/DQoNCkhlbGxvIE1hdHRoZXcsDQoNCkkgdGhp
bmsgb25seSBSUUZfUE0gcmVxdWVzdHMgc2hvdWxkIGJlIHByb2Nlc3NlZCBmb3IgZnJvemVuIFND
U0kgZGV2aWNlcw0KYW5kIG5vIG90aGVyIHJlcXVlc3RzLg0KDQpCYXJ0Lg==
