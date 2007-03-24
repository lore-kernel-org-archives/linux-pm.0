From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 17:54:12 -0700
Message-ID: <200703231754.13965.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703232139.38721.rjw@sisk.pl>
	<20070324000147.GC14427@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070324000147.GC14427@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 5:01 pm, Pavel Machek wrote:

> > tell drivers what to do.  Say we use something like PMSG_STANDBY and now
> =

> We would add another field to that struct, distingushing "mem" and
> "standby". =


Just for the record:  I continue to oppose growing pm_message_t.
