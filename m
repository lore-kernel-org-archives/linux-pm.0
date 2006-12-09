From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] Dangers
	of	touching	disk	between	suspend and resume
Date: Sat, 9 Dec 2006 15:25:18 +0000
Message-ID: <20061209152517.GA20204@srcf.ucam.org>
References: <20061128163757.GM14640@suse.de>
	<1164916843.6031.9.camel@localhost.localdomain>
	<20061130201311.GK2227@suse.de>
	<1164925067.6031.29.camel@localhost.localdomain>
	<20061201073956.GB18690@suse.de>
	<1165034513.3143.2.camel@nigel.suspend2.net>
	<20061204081049.GA12174@suse.de>
	<1165318090.15384.15.camel@nigel.suspend2.net>
	<45755D4D.3090900@genesi-usa.com>
	<1165363806.19284.8.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1165363806.19284.8.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: suspend-devel@lists.sourceforge.net, Matt Sealey <matt@genesi-usa.com>, Stefan Seyfried <seife@suse.de>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 06, 2006 at 11:10:06AM +1100, Nigel Cunningham wrote:

> Is all the converting of uuids to device nodes done in userspace? I
> haven't noticed anything in the kernel to handle uuids, but I don't look
> at filesystem code much.

Yes, this is all done by udev.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
