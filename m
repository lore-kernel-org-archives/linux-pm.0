From: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Wed, 12 Aug 2009 01:10:24 -0300
Message-ID: <8B08E6ED-5B5F-4AC0-A147-481A54ED6B55__31625.6451690153$1250050374$gmane$org@ime.usp.br>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
	<20081108075008.GA8177@ime.usp.br>
	<dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
	<20081109024514.GA11744@ime.usp.br>
	<20081109113332.GD6094@elf.ucw.cz>
	<dd18b0c30811092117mc7bd310kaac33f5b1ff0a61d@mail.gmail.com>
	<20081110074516.GB707@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081110074516.GB707@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi, Pavel and other people.

I'm just resurrecting this old bug (and everybody that was involved  =

with it), as it's been quite some time now and I still have the exact  =

same problems, unfortunately. :-(

(I wrote the comments below in the past year, but they are still valid).

On Nov 10 2008, Pavel Machek wrote:
>> FWIW, running radeon and s2ram
>> gives me a successful wakeup,
>> no delays only bluetooth-applet fails
>> to show back up as eye candy.

It seems that s2disk doesn't hang here, from a limited test, but I will
stress test this thing a bit further to see what is happening.

> So 2.6.28-rc3 actually works for you? Good ;-).

You were replying to Justin, just to make sure. :-) The attributions are
now completely messed up. :-)

Funnily, Ubuntu's intrepid doesn't have s2ram (I think that I'll grab it
from Debian for further testing).

(...)

If anybody has any idea on how to proceed, I would be thankful.


Thanks, Rog=E9rio Brito.

-- =

Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
