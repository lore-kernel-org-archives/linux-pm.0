From: Stanislaw Gruszka <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:668
	tick_broadcast_oneshot_control+0x17d/0x190()
Date: Tue, 11 Feb 2014 17:27:21 +0100
Message-ID: <20140211162720.GA3729@redhat.com>
References: <52F84A9B.5020008@gmail.com>
	<alpine.DEB.2.02.1402101056260.21991@ionos.tec.linutronix.de>
	<52F9219B.5020003@gmail.com> <20140211082306.GA1528@redhat.com>
	<alpine.DEB.2.02.1402111702090.21991@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kernel-bounces-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1402111702090.21991-3cz04HxQygjZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
List-Unsubscribe: <https://admin.fedoraproject.org/mailman/options/kernel>,
	<mailto:kernel-request-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.fedoraproject.org/pipermail/kernel/>
List-Post: <mailto:kernel-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org>
List-Help: <mailto:kernel-request-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org?subject=help>
List-Subscribe: <https://admin.fedoraproject.org/mailman/listinfo/kernel>,
	<mailto:kernel-request-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org?subject=subscribe>
Sender: kernel-bounces-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org
Errors-To: kernel-bounces-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Olaf Hering <olaf-QOLJcTWqO2uzQB+pC5nmwQ@public.gmane.org>, Mailing-List fedora-kernel <kernel-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Boyer <jwboyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, poma <pomidorabelisima-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Justin M. Forbes" <jforbes-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

PiA+IEkgY2FtZSB3aXRoIGEgYmVsb3cgcGF0Y2gsIHdoaWNoIGFsc28gY2xlYXIgcGVuZGluZyBt
YXNrLCBidXQgcGVyaGFwcwo+IAo+IEZ1bi4gSSBjYW1lIHVwIHdpdGggdGhlIGV4YWN0IHNhbWUg
c29sdXRpb24gaW5kZXBlbmRlbnQgb2YgeW91IGFuZCBJCj4gdGVzdGVkIGl0IG9uIHJlYWwgQzFF
IGNvbnRhbWluYXRlZCBoYXJkd2FyZS4KPiAKPiA+IG9uZXNob3RfbWFzayBzaG91bGQgbm90IGJl
IGNsZWFyZWQgb24gdGlja19icm9hZGNhc3Rfc2V0dXBfb25lc2hvdCgpLAo+ID4gb3Igc2hvdWxk
IGJlIGNsZWFyZWQgb25seSBjb25kaXRpb25hbGx5LCBvciBzb21lIG90aGVyIHNvbHV0aW9uIGlz
Cj4gCj4gV2UgY2FuIGRvIGl0IHVuY29uZGl0aW9uYWxseS4gSXQgY3JlYXRlcyBjb25zaXN0ZW50
IHN0YXRlIGluIGFsbAo+IGNvcm5lciBjYXNlcy4KPiAKPiBUaGVyZSBhcmUgb3RoZXIgc29sdXRp
b25zIHRvIHRoZSBwcm9ibGVtLCBidXQgdGhhdCBuZWVkcyBhIG1ham9yCj4gcmV3b3JrIG9mIHRo
ZSBicm9hZGNhc3QgY29kZS4gSSBzbyB3aXNoIHRoYXQgdGhpcyBtZXNzIHdvdWxkIGhhdmUKPiBu
ZXZlciBiZWVuIG5lY2Vzc2FyeSBhdCBhbGwgLi4uCgpUaG9tYXMsIHBsZWFzZSBwb3N0L2FwcGx5
IHBhdGNoLCB3aGljaCB5b3UgdGhpbmsgaXMgdGhlIG1vc3QKYXBwcm9wcmlhdGUuCgpUaGFua3MK
U3RhbmlzbGF3Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmtlcm5lbCBtYWlsaW5nIGxpc3QKa2VybmVsQGxpc3RzLmZlZG9yYXByb2plY3Qub3JnCmh0dHBz
Oi8vYWRtaW4uZmVkb3JhcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXJuZWw=
