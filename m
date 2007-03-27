From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC] dynamic device power management proposal
Date: Tue, 27 Mar 2007 14:19:53 +0200
Message-ID: <200703271419.54341.oneukum@suse.de>
References: <200703221905.l2MJ5VEU017196@olwen.urbana.css.mot.com>
	<20070327120543.GF5161@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070327120543.GF5161@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 27. M=E4rz 2007 14:05 schrieb Pavel Machek:
> High-latency devices indeed may be served better by separating the
> semantics. Fortunately the high-latency (we are talking >50msec here,

USB takes a minimum of 30ms to resume a device.

	Regards
		Oliver
-- =

SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
This signature is a legal requirement
