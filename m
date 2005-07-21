From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [RFT] solve "swsusp plays yoyo" with disks
Date: Thu, 21 Jul 2005 16:11:40 +0200
Message-ID: <42DFAD1C.80004@stud.feec.vutbr.cz>
References: <20050705172953.GA18748@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050705172953.GA18748@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> I'd like to get this tested under as many configurations as
> possible. With this, your hdd should no longer do "yoyo" (spindown,
> spinup, spindown) during suspend...

It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
But my disks still yoyo during suspend. What more is needed? Some patch 
to ide-disk.c ?

Michal
