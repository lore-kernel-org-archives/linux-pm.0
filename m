Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FD376BFD
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001777; cv=none; b=LD3kAymy/NqbnCKHg32B5av0StrUJ0wd5emhblfSXmA1dgnY18nsDj8GwPXtCYiUHpvYrik68n9pwBpbEEHhRI61foqsg10m0vWx/ERNcwFLo6omNsntZsrgAmP5Z10MqbmqPLbHv3hPf2nn+vogYkDKb5qKCHQyJ78vFVEy1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001777; c=relaxed/simple;
	bh=VtTaZcx9J4OQNYRXVnHCSWmI5D5sNtSzjnPHoYkoP9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkmjOJUFPNolR0Dded1j9LwkLaJrJ8MgyNxBpVxUlEQfrVKuh5xsccyNd0fOtSBHcS5tbukXk2hYxg7NpBgTzSdjZAsonotLkEHkVUtcP5f1ZoUPxLPnhKUEgmK89fNZGN5gBA5i47ySJYB2wAF94my5GSaJMg3Y4MktA07WeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UUbvK1X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w70ShvmX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UUbvK1X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w70ShvmX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UUbvK1X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w70ShvmX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UUbvK1X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w70ShvmX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CDC84D245;
	Fri, 20 Mar 2026 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774001771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQ8nt7bngIahK16G6JePyRsCLf+I3rTRe5FCH/VcwA=;
	b=0UUbvK1X2FYEZQaS1wUAGj5tezQ+VlcwiVNbUqyu5fZRSHzSPJ9wmnNMv9L13KoSOosO+7
	8e+atbjRpvisN8JCSDX1/sX96xGki0P7/gmMF16UzMCqghqr+ox8uTOxaVyctDMPbzIVWG
	c8LbnAtW0chbBbkDHPpVBc+Ad8TcRbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774001771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQ8nt7bngIahK16G6JePyRsCLf+I3rTRe5FCH/VcwA=;
	b=w70ShvmXtb/ZAYOXVJ1wdzVAGphp5TRxadbzZnnrp5UdAB7tmWWT+Jf8FSJqp6UUk1a+xK
	+cXjSP0AA36jy5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0UUbvK1X;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w70ShvmX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774001771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQ8nt7bngIahK16G6JePyRsCLf+I3rTRe5FCH/VcwA=;
	b=0UUbvK1X2FYEZQaS1wUAGj5tezQ+VlcwiVNbUqyu5fZRSHzSPJ9wmnNMv9L13KoSOosO+7
	8e+atbjRpvisN8JCSDX1/sX96xGki0P7/gmMF16UzMCqghqr+ox8uTOxaVyctDMPbzIVWG
	c8LbnAtW0chbBbkDHPpVBc+Ad8TcRbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774001771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQ8nt7bngIahK16G6JePyRsCLf+I3rTRe5FCH/VcwA=;
	b=w70ShvmXtb/ZAYOXVJ1wdzVAGphp5TRxadbzZnnrp5UdAB7tmWWT+Jf8FSJqp6UUk1a+xK
	+cXjSP0AA36jy5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 101AD4273C;
	Fri, 20 Mar 2026 10:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xqPpA2sevWkPMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 10:16:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C80A2A0AFD; Fri, 20 Mar 2026 11:16:10 +0100 (CET)
Date: Fri, 20 Mar 2026 11:16:10 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, david@kernel.org, therealgraysky@proton.me, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] writeback: don't block sync for filesystems with
 no data integrity guarantees
Message-ID: <d6gekstnlqbjvksjly2tlwscg74o7ygxofts4xqll7nyma4wt3@kwcnmmexjxou>
References: <20260320005145.2483161-1-joannelkoong@gmail.com>
 <20260320005145.2483161-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320005145.2483161-2-joannelkoong@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 1CDC84D245
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 19-03-26 17:51:45, Joanne Koong wrote:
> Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> guarantee data persistence on sync (eg fuse). For superblocks with this
> flag set, sync kicks off writeback of dirty inodes but does not wait
> for the flusher threads to complete the writeback.
> 
> This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> in wait_sb_inodes()"). The flag belongs at the superblock level because
> data integrity is a filesystem-wide property, not a per-inode one.
> Having this flag at the superblock level also allows us to skip having
> to iterate every dirty inode in wait_sb_inodes() only to skip each inode
> individually.
> 
> Prior to this commit, mappings with no data integrity guarantees skipped
> waiting on writeback completion but still waited on the flusher threads
> to finish initiating the writeback. Waiting on the flusher threads is
> unnecessary. This commit kicks off writeback but does not wait on the
> flusher threads. This change properly addresses a recent report [1] for
> a suspend-to-RAM hang seen on fuse-overlayfs that was caused by waiting
> on the flusher threads to finish:
> 
> Workqueue: pm_fs_sync pm_fs_sync_work_fn
> Call Trace:
>  <TASK>
>  __schedule+0x457/0x1720
>  schedule+0x27/0xd0
>  wb_wait_for_completion+0x97/0xe0
>  sync_inodes_sb+0xf8/0x2e0
>  __iterate_supers+0xdc/0x160
>  ksys_sync+0x43/0xb0
>  pm_fs_sync_work_fn+0x17/0xa0
>  process_one_work+0x193/0x350
>  worker_thread+0x1a1/0x310
>  kthread+0xfc/0x240
>  ret_from_fork+0x243/0x280
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> On fuse this is problematic because there are paths that may cause the
> flusher thread to block (eg if systemd freezes the user session cgroups
> first, which freezes the fuse daemon, before invoking the kernel
> suspend. The kernel suspend triggers ->write_node() which on fuse issues
> a synchronous setattr request, which cannot be processed since the
> daemon is frozen. Or if the daemon is buggy and cannot properly complete
> writeback, initiating writeback on a dirty folio already under writeback
> leads to writeback_get_folio() -> folio_prepare_writeback() ->
> unconditional wait on writeback to finish, which will cause a hang).
> This commit restores fuse to its prior behavior before tmp folios were
> removed, where sync was essentially a no-op.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1
> 
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: John <therealgraysky@proton.me>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just slightly expand the added comment like:

> @@ -2916,6 +2911,17 @@ void sync_inodes_sb(struct super_block *sb)
>  	 */
>  	if (bdi == &noop_backing_dev_info)
>  		return;
> +
> +	/*
> +	 * If the superblock has SB_I_NO_DATA_INTEGRITY set, there's no need to
> +	 * wait for the writeout to complete, as the filesystem cannot guarantee
> +	 * data persistence on sync. Just kick off writeback and return.

For filesystems such as FUSE it is important that IO submission is done
completely asynchronously as e.g. on system suspend or with broken FUSE
server, the IO submission might hang.

								Honza

> +	 */
> +	if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY) {
> +		wakeup_flusher_threads_bdi(bdi, WB_REASON_SYNC);
> +		return;
> +	}
> +
>  	WARN_ON(!rwsem_is_locked(&sb->s_umount));
>  
>  	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a9c836d7f586..f6240f24b814 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3202,10 +3202,8 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  
>  	inode->i_fop = &fuse_file_operations;
>  	inode->i_data.a_ops = &fuse_file_aops;
> -	if (fc->writeback_cache) {
> +	if (fc->writeback_cache)
>  		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> -		mapping_set_no_data_integrity(&inode->i_data);
> -	}
>  
>  	INIT_LIST_HEAD(&fi->write_files);
>  	INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..c795abe47a4f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1709,6 +1709,7 @@ static void fuse_sb_defaults(struct super_block *sb)
>  	sb->s_export_op = &fuse_export_operations;
>  	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>  	sb->s_iflags |= SB_I_NOIDMAP;
> +	sb->s_iflags |= SB_I_NO_DATA_INTEGRITY;
>  	if (sb->s_user_ns != &init_user_ns)
>  		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
>  	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index fa7638b81246..383050e7fdf5 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -338,5 +338,6 @@ struct super_block {
>  #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
>  #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
>  #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
> +#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
>  
>  #endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ec442af3f886..31a848485ad9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,7 +210,6 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> -	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -346,16 +345,6 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>  
> -static inline void mapping_set_no_data_integrity(struct address_space *mapping)
> -{
> -	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
> -static inline bool mapping_no_data_integrity(const struct address_space *mapping)
> -{
> -	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>  {
>  	return mapping->gfp_mask;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
