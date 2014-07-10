From: "Bu, Yitian" <ybu@qti.qualcomm.com>
Subject: RE: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 07:13:56 +0000
Message-ID: <E807E903FE6CBE4D95E420FBFCC273B8706613@nasanexd01h.na.qualcomm.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
	<E807E903FE6CBE4D95E420FBFCC273B87065D4@nasanexd01h.na.qualcomm.com>
 <CAKohpokLj3LbGeZOFpSSDQ1FDREHkigcPq88xGQNub8Hc4V4NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAKohpokLj3LbGeZOFpSSDQ1FDREHkigcPq88xGQNub8Hc4V4NQ@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arvind.chauhan@arm.com" <arvind.chauhan@arm.com>, "srivatsa@mit.edu" <srivatsa@mit.edu>, "skannan@codeaurora.org" <skannan@codeaurora.org>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIFtt
YWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDEw
LCAyMDE0IDM6MTAgUE0NCj4gVG86IEJ1LCBZaXRpYW4NCj4gQ2M6IHJqd0Byand5c29ja2kubmV0
OyBsaW5hcm8ta2VybmVsQGxpc3RzLmxpbmFyby5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5l
bC5vcmc7IGFydmluZC5jaGF1aGFuQGFybS5jb207IHNyaXZhdHNhQG1pdC5lZHU7DQo+IHNrYW5u
YW5AY29kZWF1cm9yYS5vcmc7IFN0YWJsZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHVmcmVx
OiBtb3ZlIHBvbGljeSBrb2JqIHRvIHBvbGljeS0+Y3B1IGF0IHJlc3VtZQ0KPiANCj4gT24gMTAg
SnVseSAyMDE0IDEyOjM4LCBCdSwgWWl0aWFuIDx5YnVAcXRpLnF1YWxjb21tLmNvbT4gd3JvdGU6
DQo+ID4gSGkgVmlyZXNoOg0KPiA+DQo+ID4gSSBoYXZlIHZlcmlmaWVkIHRoaXMgcGF0Y2gsIGFs
bCB0aGUgaXNzdWVzIEkgcmVwb3J0ZWQgZGlzYXBwZWFyZWQuDQo+ID4gVGhhbmtzIGZvciB0aGUg
cXVpY2sgZml4Lg0KPiANCj4gUGxlYXNlIGRvbid0IHRvcCBwb3N0LiBodHRwOi8vZW4ud2lraXBl
ZGlhLm9yZy93aWtpL1Bvc3Rpbmdfc3R5bGUNCj4gDQo+IFJhZmFlbCB3b3VsZCBiZSBhZGRpbmcg
eW91cjoNCj4gDQo+IFRlc3RlZC1ieTogQnUgWWl0aWFuIDx5YnVAcXRpLnF1YWxjb21tLmNvbT4N
Cj4gDQo+IExldCB1cyBrbm93IGlmIHlvdSBkb24ndCB3YW50IHRoYXQuDQoNCkl0IGlzIG9rLCB0
aGFua3MuDQoNCg==
