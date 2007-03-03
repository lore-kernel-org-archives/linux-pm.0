From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] KVM: T60 resume fix
Date: Sat, 03 Mar 2007 04:07:53 -0800
Message-ID: <7vejo6cyxy.fsf@assigned-by-dhcp.cox.net>
References: <20070227103407.GA17819@elte.hu> <20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<45E93012.4000100@qumranet.com>
	<20070303035742.72eed3df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070303035742.72eed3df.akpm@linux-foundation.org> (Andrew
	Morton's message of "Sat, 3 Mar 2007 03:57:42 -0800")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Walker <dwalker@mvista.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Pavel@osdl.org, Avi Kivity <avi@qumranet.com>, List <linux-kernel@vger.kernel.org>, Linux@osdl.org, Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Len@osdl.org, Thomas Gleixner <tglx@linutronix.de>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Could you un-CC: git@vger.kernel.org from this thread, please?
