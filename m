Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259A19CD0A;
	Sun, 15 Mar 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573877; cv=none; b=gGFPMuSYtNsJMusXG7xikdc9rU51KE1EU1jM3aY0jBem+Md6PhIAWS9vYYbE6yLCDSckFFZe7j+RLbLrKegpSPaCR4SZ8MausBa2o6AStzFE02MrKWSzMCtmqnX23WmSiwFgoCCsdf8pCIvDV+i5rdUMJFu15TALUdqwDkS3fQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573877; c=relaxed/simple;
	bh=xkra8kEoCverdCIDZrHoFjQjX/uvuf0BEW3UwC8238A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ed4IxjNUHz5e4FDB/m2xUcCQcbtXMjDQ78P8Y2ReHKxS5iWzdY3/UbB7YahfVyqz7doeVTjc8AG+NqKfMOiq04A9lxmPN6oUenb+Q8+dtAyKh0OgQ9yC0DDnwPvcLX3EBJGjgWpd7rRHKAHHzZ3LA46wQVGpqwxrVzwk8EH5Uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jG9OC1hd; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jG9OC1hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=aj2fmjlhhvbdnoqmet5uslglyy.protonmail; t=1773573870; x=1773833070;
	bh=6kzIhSrQlefIonVwDS2QLdSZuz4jn+m6gzVCZWAvoXY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jG9OC1hdzmvYaLXR5Ur5hmKWynU7+BGfYCLwde3wqtjlDMwRXijjuDdlJxYxx8zuo
	 fjpPm1JaurlPVg1gSWNJyCx994Huv7nAWi+rdme5drUMtzqYAZqGicwO00LeFYhFIY
	 C/tSs5JQBPGVEPgJ7z7A5Xb1SMGRyRcvLo8/luo0Y4WeSQJ/JInUvP05LnsFd6Z04E
	 bFJ3pKJD2o+vO8HacHGgmWX6sTcszVPBR21xrTOx2CNQvIhgi84zqhMsnAQKTaJrgo
	 h0p6bKuzCbx03iGbkHlfdlLLBqYN39UjxtkLWRgVI/03aOMCn3nQwAln3H4OSG9VpB
	 rIdEQZPZ/LG/Q==
Date: Sun, 15 Mar 2026 11:24:25 +0000
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: John <therealgraysky@proton.me>
Cc: Joanne Koong <joannelkoong@gmail.com>, "linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Subject: [BUG] fuse: wb_wait_for_completion hang on suspend with fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
Message-ID: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: e2ffb5343d28f46feee85beb2462585b7ecc7789
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kernel: 6.19.6-arch1-1
Component: fs/fuse, fs/fs-writeback

--- SUMMARY ---

A suspend-to-RAM hang in wb_wait_for_completion() via sync_inodes_sb() pers=
ists on 6.19.6 when fuse-overlayfs is mounted on tmpfs. The fix introduced =
in 6.19~rc6 for Debian bug #1120058 ("fs/writeback: skip AS_NO_DATA_INTEGRI=
TY mappings in wait_sb_inodes()") does not cover this code path.

--- BACKGROUND ---

This issue was originally reported in:
https://github.com/containers/fuse-overlayfs/issues/386

The fuse-overlayfs developer identified it as a kernel issue. It was subseq=
uently bisected to commit 0c58a97f919c ("fuse: remove tmp folio for writeba=
cks and internal rb tree", merged in 6.16) and tracked in Debian as bug #11=
20058. The fix applied in 6.19~rc6 targets wait_sb_inodes(), but the hang i=
n the reporter's original trace and in this report occurs in sync_inodes_sb=
() via a separate code path that the fix does not reach.

The issue is also known to syzbot as "INFO: task hung in sync_inodes_sb" wi=
th open instances on linux-5.15, linux-6.1, and linux-6.6:

https://syzkaller.appspot.com/bug?extid=3De0232bd63c6e293aaf6a
https://syzkaller.appspot.com/bug?extid=3D4983a35cf671e5ed55b3

--- REPRODUCTION ---

mkdir -p /dev/shm/test/up
mkdir -p /dev/shm/test/tmp
mkdir -p /dev/shm/test/data

fuse-overlayfs -o "static_nlink,noacl,\
  upperdir=3D/dev/shm/test/up,\
  lowerdir=3D$HOME/.config/mozilla/firefox,\
  workdir=3D/dev/shm/test/tmp" \
  /dev/shm/test/data

firefox --profile /dev/shm/test/data/PROFILENAME

Browse to youtube and start playing a video then trigger suspend while the =
video is playing in the browser. I used XFCE4 suspend from the menu.

The display goes blank and does not recover. The system does not enter susp=
end. Switching to a tty shows the system is alive but X11 is frozen. Reboot=
 is blocked:

# reboot
Call to Reboot failed: Action suspend already in progress, refusing request=
ed reboot operation.

--- CALL TRACE (6.19.6) ---

Mar 15 06:44:42 kernel: INFO: task kworker/u128:0:106160 blocked for more t=
han 122 seconds.
Mar 15 06:44:42 kernel:       Not tainted 6.19.6-arch1-1 #1
Mar 15 06:44:42 kernel: task:kworker/u128:0  state:D stack:0     pid:106160=
 tgid:106160 ppid:2
Mar 15 06:44:42 kernel: Workqueue: pm_fs_sync pm_fs_sync_work_fn
Mar 15 06:44:42 kernel: Call Trace:
Mar 15 06:44:42 kernel:  <TASK>
Mar 15 06:44:42 kernel:  __schedule+0x457/0x1720
Mar 15 06:44:42 kernel:  schedule+0x27/0xd0
Mar 15 06:44:42 kernel:  wb_wait_for_completion+0x97/0xe0
Mar 15 06:44:42 kernel:  sync_inodes_sb+0xf8/0x2e0
Mar 15 06:44:42 kernel:  __iterate_supers+0xdc/0x160
Mar 15 06:44:42 kernel:  ksys_sync+0x43/0xb0
Mar 15 06:44:42 kernel:  pm_fs_sync_work_fn+0x17/0xa0
Mar 15 06:44:42 kernel:  process_one_work+0x193/0x350
Mar 15 06:44:42 kernel:  worker_thread+0x1a1/0x310
Mar 15 06:44:42 kernel:  kthread+0xfc/0x240
Mar 15 06:44:42 kernel:  ret_from_fork+0x243/0x280
Mar 15 06:44:42 kernel:  ret_from_fork_asm+0x1a/0x30
Mar 15 06:44:42 kernel:  </TASK>

--- MORE CONTEXT ---

Compared to the original report (which ran through systemd-sleep -> pm_susp=
end -> ksys_sync), the sync call in 6.19 has been moved into a kernel workq=
ueue via pm_fs_sync_work_fn. The hang point is identical: wb_wait_for_compl=
etion() inside sync_inodes_sb() never returns because the FUSE daemon (fuse=
-overlayfs) is unable to complete writeback while the suspend freezer is in=
 progress.

The AS_NO_DATA_INTEGRITY fix targets wait_sb_inodes(), which is a separate =
function from sync_inodes_sb(). The hung writeback completion wait in sync_=
inodes_sb() is not gated by the AS_NO_DATA_INTEGRITY check and remains unad=
dressed.

Note: prior to commit 0c58a97f919c, sync() on FUSE filesystems was effectiv=
ely a no-op, which avoided this hang at the cost of correctness. The regres=
sion was introduced when that commit made sync() actually wait on FUSE writ=
eback completion.

I am using Arch Linux but users of Fedora F43 and Debian testing are hittin=
g this bug also. See refs below.

References:
1. fuse-overlayfs upstream issue: https://github.com/containers/fuse-overla=
yfs/issues/386
2. profile-sync-daemon issue: https://github.com/graysky2/profile-sync-daem=
on/issues/411
3. Debian bug #1120058: https://bugs.debian.org/1120058
