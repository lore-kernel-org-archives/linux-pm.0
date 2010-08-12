From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 14:11:22 +0300
Message-ID: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA__12286.6256897852$1281611545$gmane$org@mail.gmail.com>
References: <20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@mit.edu>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgMTo0NyBQTSwgVGhlb2RvcmUgVHNvIDx0eXRzb0BtaXQu
ZWR1PiB3cm90ZToKPiBPbmUgdGhpbmcgSSdtIG5vdCBjbGVhciBvbiAtLS0gd2hhdCdzIHlvdXIg
Z29hbD8gwqAgSXMgeW91ciBnb2FsIHRvIGtlZXAgc3VzcGVuZC1ibG9ja2VycyBvdXQgb2YgdGhl
IGtlcm5lbD8gwqAgSXMgaXQgdG8gdHJ5IHRvIGNvbnZpbmNlIHRoZSBhbmRyb2lkIHRlYW0gc3Vz
cGVuZC1ibG9ja2VycyBhcmUgYSBiYWQgaWRlYSBhbmQgdG8gY2hhbmdlIEFuZHJvaWQgdG8gbm90
IHVzZSB0aGVtPyDCoElzIGl0IHRvIHB1c2ggc29tZSBvdGhlciBhZ2VuZGE/IMKgSXMgaXQgdG8g
ZGlzY291cmFnZSB0aGUgQW5kcm9pZCB0ZWFtIGZyb20gdHJ5aW5nIHRvIHdhc3RlIG1vcmUgdGlt
ZSB0cnlpbmcgdG8gZ2V0IHN1c3BlbmQtYmxvY2tlcnMgKG9yIGVxdWl2YWxlbnQgZnVuY3Rpb25h
bGl0eSkgZnJvbSBiZWluZyBhZGRlZCBpbnRvIHRoZSBrZXJuZWw/CgpNeSBnb2FsIGlzIHRvIHNo
aW5lIGxpZ2h0LiBJJ3ZlIGhlYXJkIG1hbnkgaW52YWxpZCBhcmd1bWVudHMgaW4gZmF2b3IKb2Yg
c3VzcGVuZCBibG9ja2VycywgSSB3YW50IHRvIHNodXQgdGhlbSBkb3duLgoKSW4gbXkgbWluZCBp
dCdzIGNyeXN0YWwgY2xlYXIgdGhhdCBpbmRlcGVuZGVudGx5IG9mIHdoYXQgb3Bwb3J0dW5pc3Rp
YwpzdXNwZW5kIGlzIHN1cHBvc2VkIHRvIGJlIGZpeGluZywgdGhlIGZhY3Qgb2YgdGhlIG1hdHRl
ciBpcyB0aGF0IGl0J3MKbm90IGEgc2lsdmVyIGJ1bGxldCBhcyBpdCdzIGNsYWltZWQgdG8gYmUu
CgpTbyBmYXIsIG5vYm9keSBoYXMgcmVmdXRlZCB0aGVzZToKIDEpIG9wcG9ydHVuaXN0aWMgc3Vz
cGVuZCBuZWVkcyBhIGdvb2QgYmVoYXZlZCB1c2VyLXNwYWNlIHRvIHdvcmsgcHJvcGVybHkKIDIp
IGlmIHN1c3BlbmQgYmxvY2tlcnMgYXJlIGVuYWJsZWQgaW4gYSBzeXN0ZW0sICphbGwqIHVzZXIt
c3BhY2UgbXVzdAppbXBsZW1lbnQgdGhlbSB0byB3b3JrIGNvcnJlY3RseQogMykgaW1wbGVtZW50
aW5nIHN1c3BlbmQgYmxvY2tlcnMgaW4gdXNlci1zcGFjZSBpcyBub3QgYSBzdHJhaWdodC1mb3J3
YXJkIHRhc2sKIDQpIHRoZXJlJ3MgYSBwb2ludCB3aGVyZSBzbGVlcGluZyAobm90IGRvaW5nIHdv
cmspIGhhcyBkaW1pbmlzaGVkIHJldHVybnMKClNvLCBhcyB0aGUgbGVuZ3RoIG9mIHRoaXMgdGhy
ZWFkIGhhcyBzaG93biwgdGhlIGJlbmVmaXRzIG9mCm9wcG9ydHVuaXN0aWMgc3VzcGVuZCBhcmUg
KmR1YmlvdXMqIGF0IGJlc3QsIGFuZCBtb3JlIGxpa2VseSBub3Qgd29ydGgKdGhlIGNoYW5nZXMg
bmVlZGVkIGluIHVzZXItc3BhY2Ugd2hpY2ggZXZlbnR1YWxseSB3aWxsIGdldCBwcmV0dHkKY2xv
c2UgdG8gd2hhdCBzdXNwZW5kIGJsb2NrZXJzIGNhbiBhY2hpZXZlIGV2ZW4gaW4gaWRlYWwgY2ly
Y3Vtc3RhbmNlcwpieSBqdXN0IGRvaW5nIGR5bmFtaWMgUE0uCgotLSAKRmVsaXBlIENvbnRyZXJh
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1w
bSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
