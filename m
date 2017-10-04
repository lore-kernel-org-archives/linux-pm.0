From: Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [RFC 4/5] ext4: add fs freezing support on suspend/hibernation
Date: Wed, 4 Oct 2017 15:25:07 +0000
Message-ID: <1507130705.3583.14.camel@wdc.com>
References: <20171003185313.1017-1-mcgrof@kernel.org>
         <20171003185313.1017-5-mcgrof@kernel.org>
         <20171003195930.ivgaccdabxczar62@thunk.org>
         <20171003201321.GE2294@wotan.suse.de>
         <20171004014204.mztkdnm7wb7r6sl2@thunk.org> <20171004070523.GE3666@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004070523.GE3666@dastard>
Content-Language: en-US
Content-ID: <AE99259CB0E3BE47A44D22286C489365@namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "ONeukum@suse.com" <ONeukum@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nborisov@suse.com" <nborisov@suse.com>, "oleg.b.antonyan@gmail.com" <oleg.b.antonyan@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jgross@suse.com" <jgross@suse.com>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>, todd.e.brandt@linux.intel.co
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDE3LTEwLTA0IGF0IDE4OjA1ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IEJhc2ljYWxseSwgYmVmb3JlIHRoYXdpbmcgZmlsZXN5c3RlbXMgdGhlIHJlc3Qgb2YgdGhlIGtl
cm5lbA0KPiBpbmZyYXN0cnVjdHVyZSBuZWVkcyB0byBoYXZlIGJlZW4gcmVzdGFydGVkLiBpLmUu
IHRoZSBvcmRlcg0KPiBuZWVkcyB0byBiZToNCj4gDQo+IGZyZWV6ZSB1c2Vyc3BhY2UNCj4gZnJl
ZXplIGZpbGVzeXN0ZW1zDQo+IGZyZWV6ZSBrZXJuZWwgdGhyZWFkcw0KPiBmcmVlemUgd29ya3F1
ZXVlcw0KPiANCj4gdGhhdyB3b3JrcXVldWVzDQo+IHRoYXcga2VybmVsIHRocmVhZHMNCj4gdGhh
dyBmaWxlc3lzdGVtcw0KPiB0aGF3IHVzZXJzcGFjZQ0KPiANCj4gYW5kIGl0IHNob3VsZCBlbmQg
dXAgdGhhdCB3YXkuDQoNCkRvZXMgdGhpcyBvcmRlciBzdXBwb3J0IGZpbGVzeXN0ZW1zIHRoYXQg
aGF2ZSBiZWVuIGltcGxlbWVudGVkIGluIHVzZXIgc3BhY2UsDQplLmcuIGZpbGVzeXN0ZW1zIGJh
c2VkIG9uIEZVU0U/DQoNClRoYW5rcywNCg0KQmFydC4=
