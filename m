From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/5] powernv, cpufreq:Add per-core locking to serialize
 frequency transitions
Date: Fri, 21 Mar 2014 14:12:53 +0530
Message-ID: <CAOh2x==Lzeatp=7BoxuSH4PfxXqWqpHJ_KcwWdXXsFAftxTMCQ@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1395317460-14811-3-git-send-email-ego@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBNYXIgMjAsIDIwMTQgYXQgNTo0MCBQTSwgR2F1dGhhbSBSLiBTaGVub3kKPGVnb0Bs
aW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+IEZyb206ICJTcml2YXRzYSBTLiBCaGF0IiA8c3Jp
dmF0c2EuYmhhdEBsaW51eC52bmV0LmlibS5jb20+Cj4KPiBPbiBQT1dFUiBzeXN0ZW1zLCB0aGUg
Q1BVIGZyZXF1ZW5jeSBpcyBjb250cm9sbGVkIGF0IGEgY29yZS1sZXZlbCBhbmQKPiBoZW5jZSB3
ZSBuZWVkIHRvIHNlcmlhbGl6ZSBzbyB0aGF0IG9ubHkgb25lIG9mIHRoZSB0aHJlYWRzIGluIHRo
ZSBjb3JlCj4gc3dpdGNoZXMgdGhlIGNvcmUncyBmcmVxdWVuY3kgYXQgYSB0aW1lLgoKUHJvYmFi
bHkgeW91IGRvbid0IG5lZWQgdGhpcyBhbnltb3JlLgoKaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTQvMy8yMS8yMwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
Cmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
