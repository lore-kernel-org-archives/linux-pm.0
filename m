From: Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [RFC 5/5] pm: remove kernel thread freezing
Date: Wed, 4 Oct 2017 01:03:54 +0000
Message-ID: <1507079033.3075.3.camel@wdc.com>
References: <20171003185313.1017-1-mcgrof@kernel.org>
         <20171003185313.1017-6-mcgrof@kernel.org>
         <1862632.MOTT9GD8nq@aspire.rjw.lan> <29004244.0jnB6Wc1z6@aspire.rjw.lan>
         <20171004004756.GN2294@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20171004004756.GN2294@wotan.suse.de>
Content-Language: en-US
Content-ID: <D1582BCFB2ECA54AA1DDB3045308F668@namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "ONeukum@suse.com" <ONeukum@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nborisov@suse.com" <nborisov@suse.com>, "oleg.b.antonyan@gmail.com" <oleg.b.antonyan@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "jgross@suse.com" <jgross@suse.com>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>, "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>, mart
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDE3LTEwLTA0IGF0IDAyOjQ3ICswMjAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90
ZToNCj4gICAzKSBMb29rdXAgZm9yIGt0aHJlYWRzIHdoaWNoIHNlZW0gdG8gZ2VuZXJhdGUgSU8g
LS0gYWRkcmVzcyAvIHJldmlldyBpZg0KPiAgICAgIHJlbW92YWwgb2YgdGhlIGZyZWV6ZXIgQVBJ
IGNhbiBiZSBkb25lIHNvbWVob3cgd2l0aCBhIHF1ZXNjaW5nLiBUaGlzDQo+ICAgICAgaXMgY3Vy
cmVudGx5IGZvciBleGFtcGxlIGJlaW5nIGRvbmUgb24gU0NTSSAvIG1kLg0KPiAgNCkgT25seSBh
ZnRlciBhbGwgdGhlIGFib3ZlIGlzIGRvbmUgc2hvdWxkIHdlIGNvbnNpZGVyIHRoaXMgcGF0Y2gg
b3Igc29tZQ0KPiAgICAgZm9ybSBvZiBpdC4NCg0KQWZ0ZXIgaGF2aW5nIGdpdmVuIHRoaXMgbW9y
ZSB0aG91Z2h0LCBJIHRoaW5rIHdlIHNob3VsZCBvbWl0IHRoZXNlIGxhc3QgdHdvDQpzdGVwcy4g
TW9kaWZ5aW5nIHRoZSBtZCBkcml2ZXIgc3VjaCB0aGF0IGl0IGRvZXMgbm90IHN1Ym1pdCBJL08g
cmVxdWVzdHMgd2hpbGUNCnByb2Nlc3NlcyBhcmUgZnJvemVuIHJlcXVpcmVzIGVpdGhlciB0byB1
c2UgdGhlIGZyZWV6ZXIgQVBJIG9yIHRvIG9wZW4tY29kZSBpdC4NCkkgdGhpbmsgdGhlcmUgaXMg
Z2VuZXJhbCBhZ3JlZW1lbnQgaW4gdGhlIGtlcm5lbCBjb21tdW5pdHkgdGhhdCBvcGVuLWNvZGlu
ZyBhDQpzaW5nbGUgbWVjaGFuaXNtIGluIG11bHRpcGxlIGRyaXZlcnMgaXMgd3JvbmcuIERvZXMg
dGhpcyBtZWFuIHRoYXQgaW5zdGVhZCBvZg0KcmVtb3ZpbmcgdGhlIGZyZWV6ZXIgQVBJIHdlIHNo
b3VsZCBrZWVwIGl0IGFuZCByZXZpZXcgYWxsIGl0cyB1c2VycyBpbnN0ZWFkPw0KDQpCYXJ0Lg0K
