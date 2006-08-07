From: Mattia Dongili <malattia@linux.it>
Subject: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Date: Mon, 7 Aug 2006 21:38:36 +0200
Message-ID: <20060807193836.GA4007@inferi.kami.home>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

after resume from ram (tested in single user), I can type commands for a
few seconds (time is variable), the processes get stuck in io_schedule.
Poorman's screenshots are here:
http://oioio.altervista.org/linux/dsc03448.jpg
http://oioio.altervista.org/linux/dsc03449.jpg

.config:
http://oioio.altervista.org/linux/config-2.6.18-rc3-mm2-1

Anything useful I could add?
-- =

mattia
:wq!
