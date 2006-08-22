From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: T60 not coming out of suspend to RAM
Date: Tue, 22 Aug 2006 13:37:31 +0300
Message-ID: <20060822103731.GC13782@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz, linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!
I'm running Linus' git tree on my thinkpad T60.
It generally seems to work fine after suspend to disk.
However, the system does not come out of suspend to ram,
with screen staying blank. I'm looking for hints for debugging this.

If I set suspend/resume event tracing, I see this in dmesg
after reboot:

dmesg -s 1000000 | grep 'hash matches'
  hash matches drivers/base/power/resume.c:42
  hash matches device serio2

serio2 seems to be the psmouse device:
ls /sys/bus/serio/drivers/psmouse/
bind bind_mode description serio0 serio2 unbind

Does this mean the mouse driver blocks the resume?

I've rebuilt psmouse as a module, unloaded it before suspend, and now
I see the same behaviour but after reboot:
dmesg -s 1000000 | grep 'hash matches'
  hash matches drivers/base/power/resume.c:42
  hash matches device i2c-9191

Which is somewhat weird because
ls /sys/bus/i2c/devices
does not list any i2c devices

I could continue disabling stuff - but I am looking in the
correct place even? How do you debug resume issues?

Thanks,

-- =

MST
