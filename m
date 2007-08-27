From: "Tim Teulings" <rael@edge.ping.de>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Date: 27 Aug 2007 09:14:48 +0200
Message-ID: <46D279E8.10001__27887.5914206312$1188225948$gmane$org@edge.ping.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070827065246.GA21220@ime.usp.br>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@gmail.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

Hallo!

I also have 800MHz iBook (2.2, 2 USB) and had the same problem with the=20
21.6.22 kernel a while ago and reverted back to 2.6.21. I'm not a kernel=20
guy but I think I remember from kernel traces that it looked like (wise=20
chosen words ;-)) that the problems had something to do with=20
deactivating the firewire "subsystem".

I don't have traces at hand and due to lack of time cannot reproduce it=20
up to tomorrow. However this hint may speed up your analysis!

[rather long To-list, is everybody happy with this?]

--=20
Gru=DF...
        Tim
