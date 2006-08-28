From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: T60 not coming out of suspend to RAM
Date: Mon, 28 Aug 2006 16:53:58 +0300
Message-ID: <20060828135358.GC24261@mellanox.co.il>
References: <20060825110441.GB8538@elf.ucw.cz>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060825110441.GB8538@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

OK, it turns out the problem was with running SATA drive in AHCI mode.

After applying the following patch from Forrest Zhao
http://lkml.org/lkml/2006/7/20/56
both suspend to disk and suspend to ram work fine now.
This patch is going into 2.6.18, isn't it?

Huge thanks to Thomas Glanzman for help in tracking this down.
You rock.

-- =

MST
