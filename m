From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 11:00:42 +1100
Message-ID: <1205280042.764.28.camel__30185.916418168$1205280242$gmane$org@nigel-laptop>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <20080311232415.GA26320@elf.ucw.cz>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080311232415.GA26320@elf.ucw.cz>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Wed, 2008-03-12 at 00:24 +0100, Pavel Machek wrote: 
> ...OTOH this is probably only chance to eliminate freezer from
> swsusp...

I think eliminating the freezer and having reliable hibernation under
load look like incompatible goals at the moment. Do you see that as 'not
a problem' or have some idea on how that issue can be addressed?

Regards,

Nigel
