From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 10/13] PM: earlysuspend: Add console switch
	when user requested sleep state changes.
Date: Thu, 5 Feb 2009 11:54:36 +0100
Message-ID: <200902051154.37318.u.luckas@road.de>
References: <1233802226-23386-2-git-send-email-arve@android.com>
	<20090205090316.GD2077@elf.ucw.cz>
	<d6200be20902050137q19cf544fx40f2f3167289ab42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902050137q19cf544fx40f2f3167289ab42@mail.gmail.com>
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
Cc: swetland@google.com, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thursday, 5. February 2009, Arve Hj=F8nnev=E5g wrote:
> On Thu, Feb 5, 2009 at 1:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > ...and how is it different from current console switching we do on PC?
>
> It is not, but we turn off the framebuffer before the normal suspend
> path so we need the switch here.
Couldn't you just keep drawing to the disabled frame buffer?

Uli
-- =


------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
