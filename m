From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [RFC PATCH] tools/power turbostat: fix parameter passing for
 forked command
Date: Thu, 16 Jul 2015 08:49:44 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402FA5B7@SHSMSX101.ccr.corp.intel.com>
References: <1436580141-26507-1-git-send-email-yu.c.chen@intel.com>
 <CAJvTdK=2bN7eYLLNrFZh7tMbiHgCjNenvf8ggSDRKhOK7XAQNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3012 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbbGPIwx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jul 2015 04:52:53 -0400
In-Reply-To: <CAJvTdK=2bN7eYLLNrFZh7tMbiHgCjNenvf8ggSDRKhOK7XAQNA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsZW5iNDE3QGdtYWlsLmNvbSBb
bWFpbHRvOmxlbmI0MTdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgTGVuDQo+IEJyb3duDQo+IFNl
bnQ6IFRodXJzZGF5LCBKdWx5IDE2LCAyMDE1IDk6MTggQU0NCj4gVG86IENoZW4sIFl1IEMNCj4g
Q2M6IEJyb3duLCBMZW47IFd5c29ja2ksIFJhZmFlbCBKOyBaaGFuZywgUnVpOyBMaW51eCBQTSBs
aXN0DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIXSB0b29scy9wb3dlciB0dXJib3N0YXQ6IGZp
eCBwYXJhbWV0ZXIgcGFzc2luZyBmb3INCj4gZm9ya2VkIGNvbW1hbmQNCj4gDQo+IFRoYW5rcyBm
b3IgcmVwb3J0aW5nIHRoaXMsIFl1Lg0KPiANCj4gRG9lcyB0aGlzIHByZS1wZW5kaW5nIGEgJysn
IHRvIGdldG9wdF9sb25nJ3Mgb3B0c3RyaW5nIHRvIHByZXZlbnQgaXQgZnJvbQ0KPiBwZXJtdXRp
bmcgdGhlIGFyZ3VtZW50cyBoZWxwPzoNCj4gDQo+IA0KPiAtICAgICAgIHdoaWxlICgob3B0ID0g
Z2V0b3B0X2xvbmdfb25seShhcmdjLCBhcmd2LCAiQzpjOkRkaGk6Sk06bTpQcFNUOnYiLA0KPiAN
Cj4gKyAgICAgICB3aGlsZSAoKG9wdCA9IGdldG9wdF9sb25nX29ubHkoYXJnYywgYXJndiwNCj4g
KyAiK0M6YzpEZGhpOkpNOm06UHBTVDp2IiwNCj4gDQpZZWFoLCBpdCB3b3Jrcy4gDQpUaGFua3Mh
DQo+IA0KPiANCj4gTGVuIEJyb3duLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENlbnRl
cg0K
