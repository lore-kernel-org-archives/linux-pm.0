From: Vlad Zakharov <Vladislav.Zakharov@synopsys.com>
Subject: cpufreq: get cpufreq_frequency_table from clk driver
Date: Tue, 21 Feb 2017 11:13:35 +0000
Message-ID: <1487675614.25108.30.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41859 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdBULNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 06:13:41 -0500
Content-Language: en-US
Content-ID: <5E738EEAB7746F4F93A8B73912CDD7FB@internal.synopsys.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

SGVsbG8sDQoNCkkgYW0gdHJ5aW5nIHRvIGltcGxlbWVudCBhIGNwdWZyZXEgZHJpdmVyIGZvciBB
UkNIUyBjcHUuDQoNCkFuZCBJIGZhY2VkIHdpdGggb25lIHF1ZXN0aW9uIEkgYW0gbm90IGFibGUg
dG8gYW5zd2VyIG15c2VsZi4gY3B1ZnJlcSBmcmFtZXdvcmsgYWxsb3dzIHVzIHVzaW5nIGNwdWZy
ZXEgZnJlcXVlbmN5IHRhYmxlcw0KdGhhdCBzdG9yZSBhdmFpbGFibGUgZm9yIGN1cnJlbnQgcG9s
aWN5IHJhbmdlIG9mIGZyZXF1ZW5jaWVzIHdpdGggYW55IGFkZGl0aW9uYWwgZGF0YS4gQXMgSSB1
bmRlcnN0YW5kIGZvciBleGFtcGxlIGl0DQpjYW4gYmUgY2xvY2sgY29uZmlndXJhdGlvbnMgZm9y
IHRoaXMgcGFydGljdWxhciBmcmVxdWVuY3kuDQoNCkFsc28gSSBoYXZlIGEgY2xrIGRyaXZlciB0
aGF0IG1hbmFnZXMgYWN0dWFsIGNwdSBmcmVxdWVuY3kuIEluIGZhY3QgaXQgdXNlcyB2ZXJ5IHNp
bWlsYXIgdGFibGVzIHRoYXQgY29udGFpbiBmcmVxdWVuY2llcw0KYW5kIGNvcnJlc3BvbmRpbmcg
dmFsdWVzIG9mIGNsb2NrIGNvbmZpZ3VyYXRpb25zIHJlZ2lzdGVycyB0aGF0IGFyZSB0byBiZSBz
ZXQgdXAgd2l0aCBjdXJyZW50IGZyZXF1ZW5jeS4NCg0KU28gdGhlIHF1ZXN0aW9uIGlzIGNhbiBJ
IGdldCBzdWNoIHRhYmxlcyBmcm9tIGNsayBkcml2ZXIgc29tZWhvdz8gSSB3b3VsZCBiZSB2ZXJ5
IGNvbnZlbmllbnQ6IHRoaXMgdGFibGVzIGRpZmZlcnMgZm9yDQpBUkNIUyBDUFUuIEUuZy4gb24g
ZGlmZmVyZW50IGJvYXJkcyBpdCBpcyBjbG9ja2VkIGJ5IGRpZmZlcmVudCBQTExzIGFuZCBvc2Np
bGxhdG9ycy4NCg0KRG8geW91IGtub3cgYW55IHdheSB0byBnZXQgdGhlIHRhYmxlcyBmcm9tIGNs
ayBkcml2ZXI/IEFueSBzdWdnZXN0aW9ucyBvciBjb21tZW50cyBtaWdodCBiZSB2ZXJ5IGhlbHBm
dWwuDQoNClRoYW5rcyENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkIFpha2hhcm92IDx2emFr
aGFyQHN5bm9wc3lzLmNvbT4=
